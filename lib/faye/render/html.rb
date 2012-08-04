module Faye

  module Render
    class Html < Base
      rule :head   {|s, n| "<h#{n}>#{s}</h#{n}>" }
      rule :para   {|s| "<p>#{s}</p>" }
      rule :quote  {|s| "<blockquote>#{s}</quote>" }
      rule :code   {|s| "<pre><code>#{s}</code></pre>" }
      rule :list   {|l| "<ul>#{l.map{|i|"<li>#{i}</li>"}.join}</ul>" }
      rule :olist  {|l| "<ol>#{l.map{|i|"<li>#{i}</li>"}.join}</ol>" }
      # ---
      rule :bold   {|s| "<b>#{s}</b>" }
      rule :strong {|s| "<strong>#{s}</strong>" }
      rule :italic {|s| "<i>#{s}</i>" }
      rule :icode  {|s| "<code>#{s}</code>" }
      rule :image  {|l, a, f| "<img src='#{l}' alt='#{a}' style='float: #{f}'></img>" }
      rule :link   {|l, s| "<a href='#{l}'>#{s}</a>"}
    end
  end

  class Element
    def to_html
      Render::HTML.render(self)
    end
  end

end
