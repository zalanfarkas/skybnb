require 'rails_helper'

feature 'Admin Control Panel', :type => :feature do
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:room) {FactoryGirl.create(:room)}
  let(:reservation) {FactoryGirl.create(:reservation)}
  let(:reservation2) {FactoryGirl.create(:reservation2)}
  let(:reservation3) {FactoryGirl.create(:reservation3)}
  let(:reservation4) {FactoryGirl.create(:reservation4)}
  
  scenario "Unauthenticated User tries to access Admin control panel" do
    
    visit '/manage_rooms'
    expect(page).not_to have_content("You need to sign in or sign up before continuing.", wait: 3)
    expect(page).to have_content('Login')
    expect(page).to have_content('Admin Interface: Login')
    visit '/manage_reservations'
    expect(page).not_to have_content("You need to sign in or sign up before continuing.", wait: 3)
    expect(page).to have_content('Login')
    expect(page).to have_content('Admin Interface: Login')
  end
  
  scenario "Non-admin User tries to access Admin control panel" do
    
    host_login
    visit '/manage_rooms'
    expect(page).not_to have_content("You need to sign in or sign up before continuing.", wait: 3)
    expect(page).to have_content('Login')
    expect(page).to have_content('Admin Interface: Login')
    visit '/manage_reservations'
    expect(page).not_to have_content("You need to sign in or sign up before continuing.", wait: 3)
    expect(page).to have_content('Login')
    expect(page).to have_content('Admin Interface: Login')
  end
  
  scenario "Admin can access Admin control panel" do
    
    admin_login
    expect(page).not_to have_content("Signed in successfully.", wait: 3)
    expect(page).to have_content('Logout')
    click_on 'Manage Rooms'
    expect(page).to have_content('Search and Manage Rooms registered on SkyBnB')
    fill_in 'email', with: host.email
    fill_in 'price', with: 10
    click_on 'Search' 
    expect(page).to have_css('.panel-heading')
    expect(page).to have_css('.panel-body')
    visit '/'
    
    click_on 'Manage Reservations'
    fill_in 'email', with: 'guest.email'
    click_on 'Search'
    expect(page).to have_css('.panel-heading')   
    visit '/'
    
    within('body'){expect(page).to have_content('London')}
    expect(page).to have_content('Logout')
    click_on 'Logout'
    expect(page).to have_content('Login')
  end
  
  
  def host_login
    visit '/login'
    fill_in 'user_email', with: host.email
    fill_in 'user_password', with: 'foobar'
    click_on 'Log in'
  end
  def guest_login
    visit '/login'
    fill_in 'user_email', with: guest.email
    fill_in 'user_password', with: 'foobar'
    click_on 'Log in'
  end
  def admin_login
    visit '/admin123456'
    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: 'foobar'
    within('body'){click_on 'Log in'}
  end
  
end