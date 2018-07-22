### UTILITY METHODS ###
@host = FactoryGirl.create(:host)
@guest = FactoryGirl.create(:guest)

def sign_up
  visit '/sign_up'
  fill_in "user_fullname", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Log in"
end

def sign_in
  visit '/login'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Log in"
end

