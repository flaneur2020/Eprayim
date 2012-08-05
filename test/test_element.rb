require 'minitest/autorun'
require 'test/helpers.rb'

class TestElement < MiniTest::Unit::TestCase
  def setup
    @r = Render::HTML
  end

  def test_raw_para
    e = Element.new(:para, 'a', 'b')
    t = @r.render(e)
    assert_equal t, '<p>ab</p>'
  end

  def test_para_with_inline
    e = Element.new(:para, 'a', Element.new(:bold, 'b'))
    t = @r.render(e)
    assert_equal t, '<p>a<b>b</b></p>'
  end

  def test_nested_inline
    e = Element.new(:quote, 'q', Element.new(:bold, 'b', Element.new(:italic, 'i')))
    t = @r.render(e)
    assert_equal t, '<blockquote>q<b>b<i>i</i></b></blockquote>'
  end

  def test_to_html
    e = Element.new(:quote, 'q', Element.new(:bold, 'b', Element.new(:italic, 'i')))
    assert_equal e.to_html, '<blockquote>q<b>b<i>i</i></b></blockquote>'
  end

  def test_equal
    e1 = Element.new(:quote, 'q', Element.new(:bold, 'b', Element.new(:italic, 'i')))
    e2 = Element.new(:quote, 'q', Element.new(:bold, 'b', Element.new(:italic, 'i')))
    assert_equal e1, e2
  end

  def test_not_equal
    e1 = Element.new(:quote, 'q', Element.new(:bold, 'c', Element.new(:italic, 'i')))
    e2 = Element.new(:quote, 'q', Element.new(:bold, 'b', Element.new(:italic, 'i')))
    assert e1 != e2
  end
end
