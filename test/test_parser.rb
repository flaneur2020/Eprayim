require 'minitest/autorun'
require 'test/helpers.rb'

class TestParser < MiniTest::Unit::TestCase
  def setup
  end

  def test_parse_head
    str = "== h "
    r = Parser.new(str).parse_block
    assert_equal r, E(:head, 2, 'h', '')
  end

  def test_parse_head_with_anchor
    str = "== h #a"
    assert_equal PB(str), E(:head, 2, 'h', 'a')
  end

  def test_parse_head_with_trailing_text
    str = "== h #a\nhello"
    assert_equal PB(str), E(:head, 2, 'h', 'a')
  end

  def test_parse_head_code
    str = "== h #a \n```print 'hello world'```"
    p = Parser.new(str)
    r = p.parse_block
    assert_equal r, E(:head, 2, 'h', 'a')
    r = p.parse_block
    assert_equal r, E(:code, "print 'hello world'")
  end

  def test_code_escape
    str = "```print 1 < 2```"
    assert_equal PB(str).to_html, '<pre><code>print 1 &lt; 2</code></pre>'
  end

  def test_parse_quote
    str = "> quote \n> quote"
    assert_equal PB(str), E(:quote, 'quote', 'quote')
  end

  def test_nested_quote
    str = "> 1st\n> > > 3rd\n> > > 3rd\n> > 2nd\n> > 2nd\n> 1st"
    e = E(:quote, '1st', 
                    E(:quote, 
                                E(:quote, '3rd', '3rd'),
                                '2nd', '2nd'),
                   '1st')
    assert_equal e, PB(str)
  end

  def test_bad_nested_quote
    str = "> 1st\n > > > 3rd\n> > > 3rd\n> > 2nd\n> 1st"
    assert_equal PB(str), E(:quote, '1st')
  end

  def test_normal_list
    str = "+ i1\n+ i2\n+ i3"
    assert_equal PB(str), E(:list, 'i1', 'i2', 'i3')
  end

  def test_list_with_multi_line_item
    str = "+ i1\n  i1\n  i1\n\n  i1\n+ i2\n+ i3"
    assert_equal PB(str), E(:list, E(:doc, *([E(:para, 'i1')] * 4)), 'i2', 'i3')
  end

  def test_list_with_multi_line_item_to_html
    str = "+ i1\n  i1\n  i1\n\n  i1\n+ i2\n+ i3"
    assert_equal PB(str).to_html, "<ul><li><p>i1</p><p>i1</p><p>i1</p><p>i1</p></li><li>i2</li><li>i3</li></ul>"
  end

  def test_hr
    str = "---\n\n---"
    p = Parser.new(str)
    r = p.parse_block
    assert_equal r.to_html, "<hr/>"
    r = p.parse_block
    assert_equal r.to_html, "<hr/>"
  end

  def test_empty_text
    str = ''
    assert_equal nil, PB(str)
  end

  def test_parse_inline
    str = '***abc*bcd&*e*'
    assert_equal PI(str), [E(:bold, '*'), 'abc', E(:bold, 'bcd&'), 'e*'] 
  end

  def test_strong
    str = '**_**'
    assert_equal PI(str), [E(:strong, '_')]
  end

  def test_inline_html
    assert_equal E(:strong, '_').to_html, '<strong>_</strong>'
  end

  def test_nested_inline
    str = '*b_bibi_b~bdbd~*rr'
    assert_equal PI(str), [E(:bold, 'b', E(:italic, 'bibi'), 'b', E(:deleted, 'bdbd')), 'rr'] 
  end
end
