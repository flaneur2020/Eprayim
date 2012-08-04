module Faye
  module Render
    class Base
      class << self
        attr_reader :rules

        def render(element)
          args = element.children.map do |child|
            if child.is_a? Element
              render(child)
            else
              child
            end
          end
          rule = @rules[element.type]
          raise "No render rule for #{element.type} in #{self}" if not rule
          rule.call(*args)
        end

        def rule(type, &blk)
          @rules ||= {}
          @rules[type] = blk
        end
      end
    end

  end
end

