class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@user_photos = @user.user_photos
		@rooms = @user.rooms
		@number_of_reviews = 0
		if @rooms.count > 0
			@rooms.each do |room|
					if !room.reviews.nil?
						@number_of_reviews = room.reviews.count + @number_of_reviews
					end
			end
		end
	end
end