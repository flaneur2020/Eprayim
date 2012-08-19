$:.unshift << File.dirname(__FILE__)

require 'faye/element.rb'
require 'faye/lexer.rb'
require 'faye/parser.rb'
require 'faye/render.rb'
require 'faye/render/html.rb'

module Faye
  class Doc
    # the origin text before parse
    attr_reader :text

    def initialize(text)
      @text = text
    end
  end
end
