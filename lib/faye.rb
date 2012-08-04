require 'faye/parse.rb'
require 'faye/dom.rb'

module Faye
  class Doc
    # the origin text before parse
    attr_reader :text

    def initialize(text)
      @text = text
    end
  end
end
