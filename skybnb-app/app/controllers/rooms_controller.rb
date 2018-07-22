class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]
  before_action :user_type_is_host, only: [:index, :new, :create, :edit, :update]
	before_action only: [:delete] do
		:authenticate_user! || :authenticate_admin!
	end

  def index
    @rooms = current_user.rooms
  end

  def show
    @photos = @room.photos

    @booked = Reservation.where("room_id = ? AND user_id = ?", @room.id, current_user.id).present? if current_user

    @reviews = @room.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save

      if params[:images] 
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end

      @photos = @room.photos
      redirect_to edit_room_path(@room), notice: "Saved..."
    else
      flash[:alert] = "Please provide all information for this room."
      render :new
    end
  end

  def edit
    if current_user.id == @room.user.id
      @photos = @room.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @room.update(room_params)

      if params[:images] 
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end

      redirect_to edit_room_path(@room), notice: "Updated..."
    else
      render :edit
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    if current_admin || current_user.id == @room.user_id
  		@room.destroy
  		flash[:info] = "The room has been deleted.."
  		if current_admin
  		  redirect_to manage_rooms_path
  		else
  		  redirect_to rooms_path
  		end
  	else
  	  redirect_to root_path
  	  flash[:danger] = "You don't have permission.."
    end
  end

  private
    def set_room
      @room = Room.find(params[:id]) 
    end
    
    def user_type_is_host
      if current_user.user_type != "host"
        redirect_to root_path
        flash[:notice]= "URL is not available for you or it does not exist.. "
      end
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active, :image, :house_rules)
    end
end
