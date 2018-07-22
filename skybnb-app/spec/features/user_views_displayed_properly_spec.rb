require 'rails_helper'

feature "Users' views displayed according to their user type", :type => :feature do
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:room) {FactoryGirl.create(:room)}
  let(:room2) {FactoryGirl.create(:room2)}
  
  scenario "Logged in Guest is observating and clicking layout elements " do
    
    guest_login
    visit ('/')
    expect(page).to have_content('Your Trips')
    click_on 'Your Trips'
    expect(page).to have_content('Edit Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Log in')
    expect(page).to have_content('Become a Host')
    expect(page).to have_content('Messages')
    within('.nav'){click_on 'Your Trips'}
    within('div.panel-heading'){expect(page).to have_content('Your Trips')}
    within('div.col-md-3'){expect(page).to have_content('Your Trips')}
    within('div.col-md-3'){expect(page).not_to have_content('Your Reservations')}
    within('div.col-md-3'){expect(page).not_to have_content('Your Listing')}
    within('div.col-md-3'){click_on('Your Trips')}
    within('.nav'){click_on('Edit Profile')}
    within('div.panel-heading'){expect(page).to have_content('Your Profile')}
    within('div.panel-body'){expect(page).to have_content("You're current accocunt type:")}
    within('div.panel-body'){expect(page).to have_link("Upload photos")}
    within(:css, 'h3#user_type_check') do
        find(:css, '#user_user_type_guest').should be_checked
    end
    fill_in 'user_description', with: "Hello. I'm Zali..  :)"
    click_on 'Save'
    within('h2.home'){expect(page).to have_content("Just for the weekend")}
    within('.nav'){click_on 'Messages'}
    within('div.panel-heading'){expect(page).to have_content("Your conversations")}
    within('.nav'){click_on 'Become a Host'}
    within('div.panel-heading'){expect(page).to have_content('Your Profile')}
    within('div.panel-body'){expect(page).to have_content("You're current accocunt type:")}
    within('div.panel-body'){expect(page).to have_link("Upload photos")}
    within(:css, 'h3#user_type_check') do
        find(:css, '#user_user_type_guest').should be_checked
    end
    click_on 'SkyBnB'
    within('.nav'){click_on 'Logout'}
  end
  
  scenario "Logged in Host is observating and clicking layout elements " do
    
    host_login
    visit ('/')
    expect(page).to have_content('Your Trips')
    click_on 'Your Trips'
    expect(page).to have_content('Edit Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Log in')
    expect(page).not_to have_content('Become a Host')
    expect(page).to have_content('Messages')
    within('.nav'){click_on 'Your Trips'}
    within('div.panel-heading'){expect(page).to have_content('Your Trips')}
    within('div.col-md-3'){expect(page).to have_content('Your Trips')}
    within('div.col-md-3'){expect(page).to have_content('Your Reservations')}
    within('div.col-md-3'){expect(page).to have_content('Your Listing')}
    within('div.col-md-3'){click_on('Your Trips')}
    within('div.panel-heading'){expect(page).to have_content('Your Trips')}
    within('div.col-md-3'){click_on('Your Reservations')}
    within('div.panel-heading'){expect(page).to have_content('Your Reservations')}
    within('div.col-md-3'){click_on('Your Listing')}
    within('div.panel-heading'){expect(page).to have_content('Listings')}
    within('.nav'){click_on('Edit Profile')}
    within('div.panel-heading'){expect(page).to have_content('Your Profile')}
    within('div.panel-body'){expect(page).to have_content("You're current accocunt type:")}
    within('div.panel-body'){expect(page).to have_link("Upload photos")}
    within(:css, 'h3#user_type_check') do
        find(:css, '#user_user_type_host').should be_checked
    end
    fill_in 'user_description', with: "Hello. I'm Zali..  :)"
    click_on 'Save'
    within('h2.home'){expect(page).to have_content("Just for the weekend")}
    within('.nav'){click_on 'Messages'}
    within('div.panel-heading'){expect(page).to have_content("Your conversations")}
    
    click_on 'SkyBnB'
    within('.nav'){click_on 'Logout'}
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
  
end