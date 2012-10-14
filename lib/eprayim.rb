$:.unshift << File.dirname(__FILE__)

require 'eprayim/element.rb'
require 'eprayim/parser.rb'
require 'eprayim/render.rb'
require 'eprayim/render/html.rb'
require 'stringio'

module Eprayim
  class Doc
    # the origin text before parse
    attr_reader :input
    attr_reader :parser

    def initialize(input)
      @input = input
      @input = StringIO.new(input) if input.is_a? String
      @parser = Parser.new(@input)
    end

    def title
      @title ||= @parser.peek_head[0]
    end

    def anchor
      @anchor ||= @parser.peek_head[1]
    end

  end
end
