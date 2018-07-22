require 'rails_helper'

feature 'User Sign-up', :type => :feature do
  
  scenario "sign-up with valid credentials as a Guest" do
    
    visit '/sign_up'
    fill_in 'user_fullname', with: "Gigi Nagy"
    fill_in 'user_email', with: "zz11@example.com"
    fill_in 'user_password', with: 'foobar'
    page.choose('user_user_type_guest')
    click_on 'Sign up'

    expect(page).to have_content('Your Trips')
    expect(page).to have_content('Edit Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Sign up')
    expect(page).to have_content('Become a Host')
    expect(page).to have_content('Messages')
  
  end
  
  scenario "login with invalid credentials" do
  
    visit '/sign_up'
    fill_in 'user_fullname', with: "Gigi Nagy"
    fill_in 'user_email', with: "almaalma.com"
    fill_in 'user_password', with: 'alma'
    page.choose('user_user_type_host')
    click_on 'Sign up'

    expect(page).to have_content('Sign up')
    expect(page).to have_content('Login')
    expect(page).to have_content('Become a Host')
    expect(page).to_not have_content('Logout')
  end
  
  scenario "sign-up with valid credentials as a Host" do
    
    visit '/sign_up'
    fill_in 'user_fullname', with: "Gigi Nagy"
    fill_in 'user_email', with: "zz11@example.com"
    fill_in 'user_password', with: 'foobar'
    page.choose('user_user_type_host')
    click_on 'Sign up'

    expect(page).to have_content('Your Trips')
    expect(page).to have_content('Edit Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Sign up')
    expect(page).to have_content('Add a new room')
    expect(page).to have_content('Messages')
    expect(page).to have_content('Listings')
    expect(page).to have_content('Reservations')
    
  end
  
  
end