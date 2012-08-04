module Faye

  class Element
    attr_reader :type
    attr_reader :children

    def initialize(type, *args)
      @type = type
      @children = args
    end

  end

end
