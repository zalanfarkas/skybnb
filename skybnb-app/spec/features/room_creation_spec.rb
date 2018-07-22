require 'rails_helper'

feature 'Add a new room', :type => :feature do
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  
  
  scenario "Unauthenticated User tries to add a new room" do
    
    visit '/rooms/new'
    expect(page).not_to have_content("You need to sign in or sign up before continuing.", wait: 3)
    expect(page).to have_content('Log in')
    within('body') {expect(page).to have_content('Sign In with Facebook')}
    within('body') {expect(page).to have_content('Sign In with Google')}
  end
  
  scenario "Guest tries to add a new room" do
    
    guest_login
    visit '/rooms/new'
    expect(page).to have_content('Logout')
    expect(page).to have_content('London')
    expect(page).to have_content('New York')
    expect(page).to have_content('Aberdeen')
  end
  
  scenario "Host adds a new room" do
    
    host_login
    visit '/rooms/new'
    expect(page).to have_content('Logout')
    expect(page).to have_content('Create your beautiful place')
    select 'House', from: 'room_home_type'
    select 'Shared', from: 'room_room_type'
    select 2, from: 'room_accommodate'
    select 1, from: 'room_bed_room'
    select 2, from: 'room_bath_room'
    fill_in 'room_listing_name', with: "Super cute house"
    fill_in 'room_summary', with: "Tiny house in Aberdeen"
    fill_in 'room_address', with: "9 Jasmine Terrace Aberdeen UK"
    check 'room_is_heating'
    check 'room_is_internet'
    check 'room_is_kitchen'
    fill_in 'room_price', with: 5
    fill_in 'room_house_rules', with: "no smoking"
    check 'room_active'
    click_on 'Save'
    expect(page).not_to have_content("Saved..", wait: 3)
    expect(page).to have_content('Create your beautiful place')
    click_on 'Save'
    expect(page).not_to have_content("Updated..", wait: 3)
    click_on 'SkyBnB'
    
  end
  
  scenario "Admin tries to add a new room" do
    
    admin_login
    visit '/rooms/new'
    expect(page).to have_content('Logout')
    expect(page).to have_content('Log in')
    within('body') {expect(page).to have_content('Sign In with Facebook')}
    within('body') {expect(page).to have_content('Sign In with Google')}
    expect(page).not_to have_content("You need to sign in or sign up before continuing.", wait: 3)
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
    click_on 'Log in'
  end
end

  
