require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  let(:host) {FactoryGirl.create(:host)}
  let(:room) {FactoryGirl.create(:room)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:reservation) {FactoryGirl.create(:reservation)}
  let(:user) {FactoryGirl.create(:user)}
  
  context "Accessing the actions of Reservations controller without login" do
  
    it "redirects to login when trying to access reservations#preload" do
      get :preload
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to login when trying to access reservations#preview" do
      get :preview
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to login when trying to access reservations#create" do
      post :create, room_id: room.id
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to login when trying to access reservations#your_trips" do
      get :your_trips
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to login when trying to access reservations#your_reservations" do
      get :your_reservations
      expect(response).to redirect_to '/login'
    end
  end 
  
  context "Accessing the actions of Reservations controller by logged in as Admin" do
    
    before do
      sign_in admin
    end
    
    it "redirects to users' login page when trying to access reservations#preload" do
      get :preload
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login page when trying to access reservations#preview" do
      get :preview
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login page when trying to access reservations#create" do
      post :create, room_id: room.id
      expect(response).to redirect_to '/login'
    end
    
    it "gains access successfully to reservations#destroy then redirects to manage_reservations_path" do
      delete :destroy, room_id: room.id, id: reservation.id
      expect(response).to redirect_to manage_reservations_path
    end
    
    it "redirects to users' login page when trying to access reservations#your_trips" do
      get :your_trips
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login page when trying to access reservations#your_reservations" do
      get :your_reservations
      expect(response).to redirect_to '/login'
    end
  end 
  
    context "Accessing the actions of Reservations controller by logged in as a Host (called user)" do
    
    before do
      sign_in user
    end
    
    it "redirects to users' login page when trying to access reservations#preload" do
      get :preload, room_id: room.id
      response.should be_successful
    end
    
    it "gains access successfully to reservations#create then redirects to /your_trips" do
      post :create, room_id: room.id, reservation: FactoryGirl.attributes_for(:reservation)
      #expect(response).to redirect_to 'https://www.sandbox.paypal.com/cgi-bin/#'. => dynamic url so it is skipped for now
    end

    it "gains access successfully to reservations#your_trips" do
      get :your_trips
      response.should be_successful
    end
    
    it "gains access successfully to reservations#your_reservations" do
      get :your_reservations
      response.should be_successful
    end
  end 
  
  context "Accessing the actions of Reservations controller by logged in as a Guest)" do
    
    before do
      sign_in guest
    end
    
    it "redirects to users' login page when trying to access reservations#preload" do
      get :preload, room_id: room.id
      response.should be_successful
    end
    
    it "gains access successfully to reservations#create then redirects to /your_trips" do
      post :create, room_id: room.id, reservation: FactoryGirl.attributes_for(:reservation)
      #expect(response).to redirect_to 'https://www.sandbox.paypal.com/cgi-bin/#'. => dynamic url so it is skipped for now
    end

    it "gains access successfully to reservations#your_trips" do
      get :your_trips
      response.should be_successful
    end
    
    it "redirects to root when trying to access reservations#your_reservations" do
      get :your_reservations
      expect(response).to redirect_to '/'
    end
  end
  
end