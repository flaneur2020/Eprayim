$:.unshift << File.dirname(__FILE__)

require 'eprayim/element.rb'
require 'eprayim/parser.rb'
require 'eprayim/render.rb'
require 'eprayim/render/html.rb'

module Eprayim
  class Doc
    # the origin text before parse
    attr_reader :text

    def initialize(text)
      @text = text
    end
  end
end
