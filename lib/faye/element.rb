module Faye

  class Element
    TYPES = %w{ head para quote code list olist bold strong italic icode image link }.map(&:to_sym)

    attr_reader :type
    attr_reader :children

    def initialize(type, *args)
      @type = type.to_sym
      @children = args
      raise "Bad element type: #{@type}" if not TYPES.include? @type
    end
  end

end
