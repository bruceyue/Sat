require "redcarpet"
module ApplicationHelper
	def markdown(text, options={})
		options =
		{
        :autolink => true,
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
    }
		markdown = Redcarpet::Markdown.new(HTMLwithCodeRay, options)
		markdown.render(replace_emoji(text.to_s)).html_safe
	end

  def replace_emoji(text)
    text.gsub(/:(\S+):/) do |emoji|

      emoji_code = emoji #.gsub("|", "_")
      emoji      = emoji_code.gsub(":", "")

      if MdEmoji::EMOJI.include?(emoji)
        file_name    = "#{emoji.gsub('+', 'plus')}.png"
        default_size = %{height="20" width="20"}

        %{<img src="/assets/emojis/#{file_name}" class="emoji" } +
          %{title="#{emoji_code}" alt="#{emoji_code}" #{default_size}>}
      else
        emoji_code
      end
    end
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = 'text' if language.blank?
      CodeRay.scan(code, language).div(line_numbers: :inline, bold_every: 1)
    end

    def autolink(link, link_type)
      # return link
      if link_type.to_s == "email"
        link
      else
        begin
          link.match(/.+?/)
        rescue
          return link
        end
        # Fix Chinese neer the URL
        bad_text = link.to_s.match(/[^\w\d:\/\-\,\$\!\_\.=\?&#+\|\%]+/im).to_s
        link = link.to_s.gsub(bad_text, '')
        "<a href=\"#{link}\" rel=\"nofollow\" target=\"_blank\">#{link}</a>#{bad_text}"
      end
    end
  end

  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

  def tag_cloud(tags)
    max = tags.max_by(&:count)
    tags.each do |tag|
      index = tag.count.to_f / Integer(max.count)
      yield(tag)
    end
  end

  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected
 
    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end
 
    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end
 
    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end
 
    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end
 
  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end
end