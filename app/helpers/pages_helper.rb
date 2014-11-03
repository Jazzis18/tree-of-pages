module PagesHelper
	def display_tree(page)
		tree = "<li>#{link_to page.name, page_path(page)}</li>"
		if page.has_children?
			tree += "<ul class=\"tree-of-pages\">"
			page.children.each do |sub_page|
				tree += "#{display_tree(sub_page)}"
			end
			tree += "</ul>"
		end
		tree.html_safe
	end

	def make_path(page)
		page.ancestors.map do |parent|
			link_to parent[:name], page_path(parent)
		end.join(' > ').html_safe
	end
	
	def make_urlpath(page)
		page.ancestors.pluck(:slug).join('/')
	end
end
