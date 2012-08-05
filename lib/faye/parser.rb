module Faye
  class Parser
    BLOCK_RULES = [
      [:head,   /\A(?<level>=+)\s*(?<title>[^=#\n]*)(?:#(?<anchor>[^\n]*))?\s*/],
      [:code,   /\A```(?<code>.*?)```\s*$/m],
      [:quote,  /\A(>([^\n]*)\n*)+/m],
      [:list,   /\A(\* ([^\n]*)\n*)+/],
      [:list,   /\A(\+ ([^\n]*)\n*)+/],
    ]

    # -------------------------

    def initialize(text)
      @text_tail = text.clone
    end

    def parse
    end

    def parse_block
      BLOCK_RULES.each do |type, regex|
        m = regex.match(@text_tail)
        next if not m
        @text_tail = m.post_match
        return self.send("parse_#{type}", m.to_s, m)
      end
      raise 'No proper pattern was matched'
    end

    private

    def parse_inline(str)
      [str]
    end

    def parse_head(str, m)
      Element.new(:head, m[:level].size, m[:title].strip, m[:anchor].to_s.strip)
    end

    def parse_code(str, m)
      Element.new(:code, m[:code].strip)
    end

    def parse_quote(str, _)
      stack = [Element.new(:quote)]
      level_last = 1
      str.each_line do |line|
        m = /^(> )+/.match(line)
        level = m[0].to_s.size / 2
        n = level - level_last
        if n > 0
          n.times do
            stack.push Element.new(:quote) 
          end
        elsif n < 0
          (-n).times do 
            e = stack.pop
            stack.last.children << e
          end
        end
        stack.last.children.push *parse_inline(m.post_match.strip)
        level_last = level
      end
      stack.last
    end

    def parse_list(str, m)
      d = str[0]
      r = str.split("#{d} ").reject(&:empty?).map do |i|
        i.strip
      end
      t = d == '+'? :list : :olist
      Element.new(t, *r)
    end

  end
end
