module ApplicationHelper
  
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase 
		if user.image
			user.image
		else
			"https://secure.gravatar.com/avatar/#{gravatar_id}"
		end
	end
	
end
