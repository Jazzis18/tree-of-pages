module ApplicationHelper
	class CustomHTML < Redcarpet::Render::HTML
		def preprocess(text)
			custom_markdown(text)
		end
		
		def custom_markdown(text)
			# italics
			text.gsub! /\\\\(.+?)\\\\/ do
				"<i>#{$1}</i>"
			end
			
			# links
			text.gsub! /\(\((.+?)\s+?\[(.+?)\]\)\)/ do
				"<a href=\"#{$1}\">#{$2}</a>"
			end
			text
		end
	end

	def markdown(text)
		options = [ hard_wrap: true ]
		markdown = Redcarpet::Markdown.new(
			CustomHTML.new(*options), extensions = {})
		
		markdown.render(text).html_safe
	end
end
