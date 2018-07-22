require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:conversation) {FactoryGirl.create(:conversation)}
  
  context "Accessing the actions of Conversations controller without login" do
  
    it "redirects to users' login page when trying to access conversations#index" do
      get :index
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login page when trying to access conversations#create"  do
      post :create
      expect(response).to redirect_to '/login'
    end
  end
  
  context "Accessing the actions of Conversations controller by logged in as Admin" do
    
    before do
      sign_in admin
    end
  
    it "redirects to users' login page when trying to access conversations#index" do
      get :index
      expect(response).to redirect_to '/login'
    end
    
    it "redirects to users' login page when trying to access conversations#create"  do
      post :create
      expect(response).to redirect_to '/login'
    end
  end
  
  context "Accessing the actions of Conversations controller by logged in as Host" do
    
    before do
      sign_in host
    end
  
    it "gains access successfully to conversations#index" do
      get :index
      response.should be_successful
    end
    
    it "gains access successfully to conversations#create"  do
      post :create, conversation: FactoryGirl.attributes_for(:conversation)
      expect(response).to redirect_to conversation_messages_path(1) # id+1 to avoid test database error
    end
  end
  
  context "Accessing the actions of Conversations controller by logged in as Guest" do
    
    before do
      sign_in guest
    end
  
    it "gains access successfully to conversations#index" do
      get :index
      response.should be_successful
    end
    
    it "gains access successfully to conversations#create"  do
      post :create, conversation: FactoryGirl.attributes_for(:conversation)
      expect(response).to redirect_to conversation_messages_path(1) # id+1 to avoid test database error
    end
  end
 
  
  
end