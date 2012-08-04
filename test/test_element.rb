require 'minitest/autorun'
require 'test/helpers.rb'
require 'lib/faye.rb'

include Faye

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
end




