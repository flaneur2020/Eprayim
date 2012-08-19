module Faye

  # 
  class Element
    TYPES = %w{ doc head para quote code list olist hr bold strong italic icode image link }.map(&:to_sym)

    attr_reader :type
    attr_reader :children

    def initialize(type, *args)
      @type = type.to_sym
      @children = args || []
      raise "Bad element type: #{@type}" if not TYPES.include? @type
    end

    def ==(other)
      return self.type == other.type && self.children == other.children
    rescue
      false
    end

    def inspect
      "#{self.type}: #{self.children}"
    end
  end


end
