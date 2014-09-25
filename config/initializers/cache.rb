users_info = {}

User.all.each do |user|
	company = user.company
	if users_info.keys.include?(company)
		users_info[company] << user
	else
		users_info[company] = [user]
	end
end

Rails.cache.write('users_info', users_info)