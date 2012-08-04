module Faye
  module Render
    class HTML < Base
      rule(:head)   {|s, n| "<h#{n}>#{s}</h#{n}>" }
      rule(:para)   {|*a| "<p>#{a.join}</p>" }
      rule(:quote)  {|*a| "<blockquote>#{a.join}</blockquote>" }
      rule(:code)   {|s| "<pre><code>#{s}</code></pre>" }
      rule(:list)   {|*l| "<ul>#{l.map{|i|"<li>#{i}</li>"}.join}</ul>" }
      rule(:olist)  {|*l| "<ol>#{l.map{|i|"<li>#{i}</li>"}.join}</ol>" }
      # ---
      rule(:bold)   {|*a| "<b>#{a.join}</b>" }
      rule(:strong) {|*a| "<strong>#{a.join}</strong>" }
      rule(:italic) {|*a| "<i>#{a.join}</i>" }
      rule(:icode)  {|a| "<code>#{a.join}</code>" }
      rule(:image)  {|l, a, f| "<img src='#{l}' alt='#{a}' style='float: #{f}'></img>" }
      rule(:link)   {|l, s| "<a href='#{l}'>#{s}</a>"}
    end
  end

  class Element
    def to_html
      Render::HTML.render(self)
    end
  end

end
