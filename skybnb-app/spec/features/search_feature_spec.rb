require 'rails_helper'

feature 'Searching', :type => :feature do
  let(:room) {FactoryGirl.create(:room)}

  scenario "Making a search (user type does not matter)" do
    
    visit '/'
    within('div.col-md-6'){fill_in 'Where are you going?', with: 'Aberdeen'}
    click_on 'Search'
    expect(page).to have_content('Entire Room')
    expect(page).to have_content('Private Room')
    expect(page).to have_content('Accommodate')
    expect(page).to have_content('Shared Room')
    expect(page).to have_content('Bedrooms')
    expect(page).to have_content('Bathrooms')
    expect(page).to have_content('TV')
    expect(page).to have_content('Kitchen')
    expect(page).to have_content('Internet')
    expect(page).to have_content('Heating')
    expect(page).to have_content('Air Conditioning')
    expect(page).to have_content('Private Room')
    expect(page).to have_button('Search')
  end

end