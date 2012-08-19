module Faye
  class Parser
    BLOCK_RULES = [
      [:head,   /\A(?<level>=+)\s*(?<title>[^=#\n]*)(?:#(?<anchor>[^\n]*))?\s*/],
      [:hr,     /\A---+\n*/],
      [:code,   /\A```(?<code>.*?)```\s*$/m],
      [:quote,  /\A(>([^\n]*)\n*)+/m],
      [:list,   /\A(\* ([^\n]*)\n*(  [^\n]*\n*)*)+/],
      [:list,   /\A(\+ ([^\n]*)\n*(  [^\n]*\n*)*)+/],
    ]

    INLINE_RULES = [
      [:icode,  /\A`(?<content>.+?)`/],
      [:strong, /\A\*\*(?<content>.+?)\*\*/],
      [:bold,   /\A\*(?<content>.+?)\*/],
      [:deleted,/\A~(?<content>.+?)~/],
      [:italic, /\A_(?<content>.+?)_/],
      [:link,   /\A\[\s*(?<float>-|\$|\^)?(?<content>.+?)\]/],
    ]

    # -------------------------

    def initialize(text)
      @text_tail = text.clone
    end

    def parse
    end

    def parse_inline(text)
      puts text
      return [] if text.empty?
      i = 0
      while not text[i..-1].empty?
        INLINE_RULES.each do |type, regex|
          m = regex.match(text[i..-1])
          next if not m
          r = case type
          when /link/ 
            parse_link(m)
          when /icode/ 
            Element.new(:icode, m[:content])
          else
            Element.new(type, *parse_inline(m[:content]))
          end
          return [r, *parse_inline(m.post_match)] if i-1 < 0
          return [text[0..i-1], r, *parse_inline(m.post_match)]
        end
        i += 1
      end
      return text[0..i]
    end

    def parse_block
      return nil if @text_tail.empty?
      BLOCK_RULES.each do |type, regex|
        m = regex.match(@text_tail)
        next if not m
        @text_tail = m.post_match
        return self.send("parse_#{type}", m.to_s, m)
      end
      raise 'No proper pattern was matched'
    end

    private

    def parse_head(str, m)
      Element.new(:head, m[:level].size, m[:title].strip, m[:anchor].to_s.strip)
    end

    def parse_hr(str, m)
      Element.new(:hr)
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
        if i =~ /^  /
          ps = i.split(/^  /).reject(&:empty?).map do |p|
            Element.new(:para, *parse_inline(p.strip))
          end
          Element.new(:doc, *ps)
        else
          i.strip
        end
      end
      t = d == '+'? :list : :olist
      Element.new(t, *r)
    end

    def parse_link(str, m)
    end

    # --------------------------

  end
end
