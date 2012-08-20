require 'cgi'

module Eprayim
  module Render
    class HTML < Base
      rule(:doc)    {|*a| a.join }
      rule(:head)   { |n, s, a| "<h#{n}>#{h s}</h#{n}>" + (a.blank? ? '': "<a name='#{a}'></a>") }
      rule(:para)   {|*a| "<p>#{a.join}</p>" }
      rule(:quote)  {|*a| "<blockquote>#{a.join}</blockquote>" }
      rule(:code)   {|s|  "<pre><code>#{h s}</code></pre>" }
      rule(:list)   {|*l| "<ul>#{l.map{|i|"<li>#{i}</li>"}.join}</ul>" }
      rule(:olist)  {|*l| "<ol>#{l.map{|i|"<li>#{i}</li>"}.join}</ol>" }
      rule(:hr)     {|*l| "<hr/>" }
      # ---
      rule(:bold)   {|*a| "<b>#{a.join}</b>" }
      rule(:strong) {|*a| "<strong>#{a.join}</strong>" }
      rule(:italic) {|*a| "<i>#{a.join}</i>" }
      rule(:icode)  {|s|  "<code>#{h s}</code>" }
      rule(:deleted){|*a| "<del>#{a.join}</del>" }
      rule(:image)  {|l, a, f| "<img src='#{l}' alt='#{a}' style='float: #{f}'></img>" }
      rule(:link)   {|l, *a| "<a href='#{l}'>#{a.join}</a>"}

      def HTML.h(t)
        CGI::escapeHTML(t)
      end
    end
  end

  class Element
    def to_html
      @html ||= Render::HTML.render(self)
    end
  end

  class Doc
    def to_html
      @html ||= parser.parse().to_html
    end
  end

end
