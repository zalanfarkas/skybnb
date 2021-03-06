require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:fullname)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:user_type)}
  #email uniqueness is tested in the database side
 
end
