require 'minitest/autorun'
require 'test/helpers.rb'

class TestElement < MiniTest::Unit::TestCase
  def setup
    @r = Render::HTML
  end

  def test_parse_head
    str = "== h "
    r = Parser.new(str).parse_block
    assert_equal r, Element.new(:head, 2, 'h', '')
  end

  def test_parse_head_with_anchor
    str = "== h #a"
    r = Parser.new(str).parse_block
    assert_equal r, Element.new(:head, 2, 'h', 'a')
  end

  def test_parse_head_with_trailing_text
    str = "== h #a\nhello"
    r = Parser.new(str).parse_block
    assert_equal r, Element.new(:head, 2, 'h', 'a')
  end

  def test_parse_head_code
    str = "== h #a \n```print 'hello world'```"
    p = Parser.new(str)
    r = p.parse_block
    assert_equal r, Element.new(:head, 2, 'h', 'a')
    r = p.parse_block
    assert_equal r, Element.new(:code, "print 'hello world'")
  end

  def test_code_escape
    str = "```print 1 < 2```"
    r = Parser.new(str).parse_block
    assert_equal r.to_html, '<pre><code>print 1 &lt; 2</code></pre>'
  end

  def test_parse_quote
    str = "> quote \n> quote"
    r = Parser.new(str).parse_block
    assert_equal r, Element.new(:quote, 'quote', 'quote')
  end

  def test_nested_quote
    str = "> 1st\n> > > 3rd\n> > > 3rd\n> > 2nd\n> 1st"
    r = Parser.new(str).parse_block
    e = Element.new(:quote, '1st', 
                    Element.new(:quote, 
                                Element.new(:quote, '3rd', '3rd'),
                                '2nd'),
                   '1st')
    assert_equal e, r
  end

  def test_bad_nested_quote
    str = "> 1st\n > > > 3rd\n> > > 3rd\n> > 2nd\n> 1st"
    r = Parser.new(str).parse_block
    assert_equal r, Element.new(:quote, '1st')
  end
end
