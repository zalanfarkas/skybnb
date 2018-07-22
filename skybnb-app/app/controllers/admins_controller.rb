class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
	def rooms
			if params[:email]
				@user = User.find_by_email(params[:email])
				if @user.nil?
					redirect_to manage_rooms_path
					flash[:info] = "There is no Host registered with this email address"
				else
					if params[:listing_name]!=""
						listing_name = params[:listing_name]
						@results = @user.rooms.find_by_listing_name(listing_name)
					elsif params[:address]!=""
						address = params[:address]
						@results = @user.rooms.find_by_address(address)
					elsif params[:price] !=""
						price = params[:price]
						@results = @user.rooms.find_by_price(price)
					else
						@results = @user.rooms
					end
				end
			if @results.class == Room
				@result = @results
				@results = nil
			end
			end
	
	end
	
  
	def reservations
		if params[:email]
			@user = User.find_by_email(params[:email])
			if @user.nil?
				redirect_to manage_reservations_path
				flash[:info] = "There is no Guest registered with this email address"
			else
				if params[:start_date]!=""
					start_date = params[:start_date]
					@results = Reservation.where(["user_id = ? and start_date = ?", @user.id, start_date.to_time])
				else
					@results = @user.reservations
				end
			end
			if @results.nil? || @results.empty?
				flash.now[:notice] = "The given user doesn't have a resevation for this start date.." 
			end
		end
	end	
  	
end