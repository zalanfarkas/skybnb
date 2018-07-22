require 'rails_helper'

feature 'Making Reservations', :type => :feature do
  let(:host) {FactoryGirl.create(:host)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:room) {FactoryGirl.create(:room)}
  
  scenario "User tries to make a reservation" do
    
  # i was unable to contunie this test due to factorygirl misconfiguration  
=begin
    guest_login
    visit room_path(room.id)
=end
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