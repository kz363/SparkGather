users_info = {}
# Hash[User.all.map { |user| [user.company, user] }]



Rails.cache.write('users_info', users_info)