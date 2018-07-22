require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  
  
  context "Accessing the actions of Admins controller without login" do
  
    it "redirects to admins' login page when trying to access admins#rooms" do
      get :rooms
      expect(response).to redirect_to '/admin123456'
    end
    
    it "redirects to admins' login page when trying to access admins#reservations" do
      get :reservations
      expect(response).to redirect_to '/admin123456'
    end
  end
  
  context "Accessing the actions of Admins controller by logged in as Admin" do
    
    before do
      sign_in admin
    end
  
    it "gains access successfully to admins#rooms" do
      get :rooms
      response.should be_successful
    end
    
    it "gains access successfully to admins#reservations" do
      get :reservations
      response.should be_successful
    end
  end
  
  context "Accessing the actions of Admins controller by logged in as Host" do
    
    before do
      sign_in host
    end
    
    it "redirects to admins' login page when trying to access admins#rooms" do
      get :rooms
      expect(response).to redirect_to '/admin123456'
    end
    
    it "redirects to admins' login page when trying to access admins#reservations" do
      get :reservations
      expect(response).to redirect_to '/admin123456'
    end
  end
  
  context "Accessing the actions of Admins controller by logged in as Guest" do
    
    before do
      sign_in guest
    end
    
    it "redirects to admins' login page when trying to access admins#rooms" do
      get :rooms
      expect(response).to redirect_to '/admin123456'
    end
    
    it "redirects to admins' login page when trying to access admins#reservations" do
      get :reservations
      expect(response).to redirect_to '/admin123456'
    end
  end
 
  
  
end