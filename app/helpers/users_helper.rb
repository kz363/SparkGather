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
end
