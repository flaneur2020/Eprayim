require 'dom.rb'

module Faye

  class Lexer

    def initialize(text)
      @text = text
      @lines = text.each_line
    end

    # aggregate the multi-lines into one block
    def get_block
      line = @lines.next
    end

  end
end
