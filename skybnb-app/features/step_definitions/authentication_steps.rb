

Given(/^I go to the login page$/) do
  visit('/users/sign_in')  
  expect(page).to have_content('Login')
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |value, text|
    value = 'user_'+value.to_s.downcase 
   fill_in(value, :with =>text)
end

When(/^I press "([^"]*)"$/) do |create|
 click_button('Login')
end

Then(/^I should be logged in$/) do
   #visit('/') 
   #expect(page).to have_content("Signed in successfully.")
   #expect(?).to match("Signed in successfully.")
   #within(".notice") {expect(page).to have_content("Signed in successfully.")}
   expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  # expect(notice).to eq('Signed in successfully.')
end

Then(/^I should be logged in so I should see different navigation bar items: "([^"]*)","([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5|
  visit('/') 
  expect(page).to have_content(arg1)
  expect(page).to have_content(arg2)
  expect(page).to have_content(arg3)
  expect(page).to have_content(arg4)
  expect(page).to have_content(arg5)
end
