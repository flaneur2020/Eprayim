require 'minitest/autorun'
require 'test/helpers.rb'

class TestAPI < MiniTest::Unit::TestCase
  def setup
  end

  def test_eprayim
    html = Eprayim::Doc.new('hello *world*').to_html
    assert html, 'hello <b>world</b>'
  end
end
