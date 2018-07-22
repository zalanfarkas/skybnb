class UserPhotosController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user_photos = current_user.user_photos[0..-1]
    @user_photo = current_user.user_photos.build
  end
  
  def create
    if !params[:user_photo].nil?
      @user_photo = current_user.user_photos.build(user_photo_params)
      if @user_photo.save
        @user_photos = current_user.user_photos
        redirect_to user_photos_path
      else
        flash[:alert] = "Something went wrong try again."
        render :index
      end
    else
      flash[:alert] = "You did not select any images."
      redirect_to user_photos_path
    end
  end
  
  def destroy
    @user_photo = UserPhoto.find(params[:id])
    @user_photo.destroy
    @user_photos = UserPhoto.where(user_id: current_user.id)

    respond_to :js
  end
  
  
  private
    def user_photo_params
      params.require(:user_photo).permit(:image)
    end
  
end