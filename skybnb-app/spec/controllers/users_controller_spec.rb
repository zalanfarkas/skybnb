require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  let(:user) {FactoryGirl.create(:user)}

  describe "GET #show" do
    it "returns http success" do
      get :show, id: user.id
      expect(response).to have_http_status(:success)
    end
  end

end
