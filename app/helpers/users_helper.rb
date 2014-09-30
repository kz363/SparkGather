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

	def page_index
		current_page - 1
	end

	def arrow_left(options = {})
		handle_end_page(0, '&laquo;', '-', options)
	end

	def arrow_right(collection, options = {})
		handle_end_page(collection.size - 1, '&raquo;', '+', options)
	end

	def pages(collection, options = {})
		raw(
		collection.each_with_index.map do |_, i|
			page_num = i + 1
			active = current_page == page_num ? 'active' : nil
			content_tag :li, class: active do
				content_tag(:a, page_num, href: "/#{path(options)}?#{queries(options)}page=#{page_num}")
			end
		end.join
		)
	end

private

	def path(options)
		options.fetch(:path, nil)
	end

	def queries(options)
		options.each_pair.map { |k, v| "#{k}=#{v}&" }.join
	end

	def current_page
		params[:page].to_i
	end

	def handle_end_page(end_page, arrow, direciton, options = {})
		disabled = page_index == end_page ? "disabled" : nil
		content_tag :li, class: disabled do
			if disabled
				content_tag(:span, arrow.html_safe).html_safe
			else
				content_tag(:a, arrow.html_safe, href: "/#{path(options)}?#{queries(options)}page=#{eval(current_page.to_s + "#{direciton}" + ' 1')}").html_safe
			end
		end
	end
end
