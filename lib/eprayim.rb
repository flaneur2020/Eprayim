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
      @title or self.peek_title[0]
    end

    def anchor
      @anchor or self.peek_title[1]
    end

    def peek_title
      return [@title, @anchor] if @title
      @input.each_line do |line|
        m = line.match Parser::BLOCK_RULES[0][1]
        if m and m[:level] == '='
          @title = m[:title].strip
          @anchor = m[:anchor].strip
          return [@title, @anchor]
        end
      end
      return [nil, nil]
    end
  end
end
