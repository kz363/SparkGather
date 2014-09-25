module ApplicationHelper
	def page_specific_js
		"#{controller_name}_#{action_name}.js"
	end
end
