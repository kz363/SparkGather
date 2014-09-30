module UsersHelper
	def info_box(title, info)
		content_tag(:th, title, class: 'sub-title', colspan: 2) +
		raw(
		info.map do |name, value|
			content_tag :tr do
				content_tag(:td, name) +
				content_tag(:td, /@user/=~ value ? eval(value) : value)
			end
		end.join
		)
	end

	def page_number
		current_page - 1
	end

	def arrow_left
		handle_end_page(0, '&laquo;', '-')
	end

	def arrow_right(companies)
		handle_end_page(companies.size - 1, '&raquo;', '+')
	end

	def pages(companies)
		raw(
		companies.each_with_index.map do |_, i|
			page_num = i + 1
			active = current_page == page_num ? 'active' : nil
			content_tag :li, class: active do
				content_tag(:a, page_num, href: "/?page=#{page_num}")
			end
		end.join
		)
	end

private

	def current_page
		params[:page].to_i
	end

	def handle_end_page(end_page, arrow, direciton)
		disabled = page_number == end_page ? "disabled" : nil
		content_tag :li, class: disabled do
			if disabled
				content_tag(:span, arrow.html_safe).html_safe
			else
				content_tag(:a, arrow.html_safe, href: "/?page=#{eval(current_page.to_s + "#{direciton}" + ' 1')}").html_safe
			end
		end
	end
end
