require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  let(:host) {FactoryGirl.create(:host)}
  let(:room) {FactoryGirl.create(:room)}
  let(:room2) {FactoryGirl.create(:room2)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  
  before(:each) do
  end
  
  context "Accessing the actions of Rooms controller without login" do
  
    it "redirects to login when trying to access rooms#index " do
      get :index
      expect(response).to redirect_to '/login'
    end
    
    it "successful access to rooms#show " do
      get :show, id: room.id
      response.should be_successful
    end
    
    it "redirects to login when trying to access rooms#update " do
      get :update, id: room.id
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to login when trying to access rooms#edit " do
      patch :edit, id: room.id
      expect(response).to redirect_to '/login'
    end
    
    
    it "redirects to login when trying to access rooms#create " do
      post :create, id: room.id
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to login when trying to access rooms#new " do
      get :new
      expect(response).to redirect_to '/login'
    end
  end
  
  context "Accessing the actions of Rooms controller by logged as Host (Owner of the Room(s))" do
    
    before do
      sign_in host
    end
    it "accesses successfully the action: rooms#index " do
      get :index
      response.should be_successful
    end
    
    it "accesses successfully the action: rooms#show " do
      get :show, id: room.id
      response.should be_successful
    end
    
    it "accesses successfully the action: rooms#update " do
      get :update, id: room.id, room: FactoryGirl.attributes_for(:room)
      expect(response).to redirect_to edit_room_path(room.id)
    end
    
    it "accesses successfully the action: rooms#destroy then redirects" do
      delete :destroy, id: room.id
      expect(response).to redirect_to '/rooms'
    end
    
    it "successful access to rooms#new " do
      get :new
      response.should be_successful
    end
    
    it "accesses successfully the action: rooms#edit " do
      patch :edit, id: room.id
    response.should be_successful
    end
  end
  
  context "Accessing the actions of Rooms controller by logged in as Guest " do
    
    before do
      sign_in guest
    end
    it "redirects to root when trying to access action: rooms#index " do
      get :index
      expect(response).to redirect_to '/'
    end
    
    it "accesses successfully the action: rooms#show " do
      get :show, id: room.id
      response.should be_successful
    end
    
    it "redirects to root when trying to access rooms#update" do
      get :update, id: room.id, room: FactoryGirl.attributes_for(:room)
      expect(response).to redirect_to '/'
    end
    
    it "redirects to root when trying to access rooms#destroy" do
      delete :destroy, id: room.id
      expect(response).to redirect_to '/'
    end
    
    it "redirects to root when trying to access rooms#create" do
      post :create, room: FactoryGirl.attributes_for(:room2)
      expect(response).to redirect_to '/'
    end
    
    it "redirects to root when trying to access rooms#new " do
      get :new
      expect(response).to redirect_to '/'
    end
    
    it "redirects to root when trying to access rooms#edit " do
      patch :edit, id: room.id
    expect(response).to redirect_to '/'
    end
  end
  
  context "Accessing the actions of Rooms controller by logged in as Admin " do
    
    before do
      sign_in admin
    end
    it "redirects to users' login path when trying to access action: rooms#index " do
      get :index
      expect(response).to redirect_to '/login'
    end
    
    it "accesses successfully the action: rooms#show " do
      get :show, id: room.id
      response.should be_successful
    end
    
    it "redirects to users' login path when trying to access rooms#update" do
      get :update, id: room.id, room: FactoryGirl.attributes_for(:room)
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to manage_rooms_path rooms#destroy" do
      delete :destroy, id: room.id
      expect(response).to redirect_to manage_rooms_path
    end
    
    it "redirects to users' login path when trying to access rooms#create" do
      post :create, room: FactoryGirl.attributes_for(:room2)
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login path when trying to access rooms#new " do
      get :new
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login path when trying to access rooms#edit " do
      patch :edit, id: room.id
    expect(response).to redirect_to '/login'
    end
  end

end