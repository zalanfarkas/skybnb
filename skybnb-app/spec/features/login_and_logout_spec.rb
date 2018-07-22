require 'rails_helper'

feature 'User Login and Logout', :type => :feature do
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  
  scenario "login with valid credentials as a Host" do
    
    visit '/login'
    fill_in 'user_email', with: host.email
    fill_in 'user_password', with: 'foobar'
    click_on 'Log in'
    
    expect(page).not_to have_content("Signed in successfully.", wait: 3)
    expect(page).to have_content('Your Trips')
    expect(page).to have_content('Edit Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Log in')
    expect(page).to have_content('Add a new room')
    expect(page).to have_content('Messages')
    expect(page).to have_content('Listings')
    expect(page).to have_content('Reservations')
    click_on 'Logout'
    expect(page).not_to have_content("Signed out successfully.", wait: 3)
    
  end
  
  scenario "login with valid credentials as a Guest" do
    
    visit '/login'
    fill_in 'user_email', with: guest.email
    fill_in 'user_password', with: 'foobar'
    click_on 'Log in'
    
    expect(page).not_to have_content("Signed in successfully.", wait: 3)
    expect(page).to have_content('Your Trips')
    expect(page).to have_content('Edit Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Log in')
    expect(page).to have_content('Become a Host')
    expect(page).to have_content('Messages')
    click_on 'Logout'
    expect(page).not_to have_content("Signed out successfully.", wait: 3)
  end
  
  scenario "login with valid credentials as an Admin" do
    
    visit '/admin123456'
    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: 'foobar'
    click_on 'Log in'
    
    expect(page).not_to have_content("Signed in successfully.", wait: 3)
    expect(page).to have_content(admin.email)
    expect(page).to have_content('Site administration tools')
    expect(page).to have_content('Manage Rooms')
    expect(page).to have_content('Manage Reservations')
    expect(page).to_not have_content('Log in')
    expect(page).to_not have_content('Admin Interface: Login')
    click_on 'Logout'
    expect(page).not_to have_content("Signed out successfully.", wait: 3)
  end
  
  
  
  scenario "login with invalid credentials" do
  
    visit '/login'
    fill_in 'user_email', with: "alma@alma.com"
    fill_in 'user_password', with: 'alma'
    click_on 'Log in'
    expect(page).not_to have_content("Invalid Email or password.", wait: 3)

    expect(page).to have_content('Log in')
    expect(page).to_not have_content('Logout')
  end
end