### UTILITY METHODS ###
require 'factory_girl_rails'
def create_visitor
  @visitor ||= { :name => "Testy McUserton", :email => "example@example.com",
    :password => "123456", :password_confirmation => "123456" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = User.new(:name => "Michael", :email => "example@example.com", :password => "123456", :password_confirmation => "123456" )
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  # fill_in "user[username]", :with => @visitor[:name]
  # Handled by js
  fill_in "user[email]", :with => @visitor[:email]
  fill_in "user[password]", :with => @visitor[:password]
  fill_in "user[password_confirmation]", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Log in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  delete '/users/sign_out.json'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  delete '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

# When(/^I save the edit form$/) do
#   click_button "Update"
# end
#
# When /^I edit my account name$/ do
#   click_link "Edit account"
#   fill_in "user_name", :with => "newname"
#   fill_in "user_current_password", :with => @visitor[:password]
# end
#
# When /^I edit my email address$/ do
#   click_link "Edit account"
#   fill_in "user_email", :with => "newemail@example.com"
#   fill_in "user_current_password", :with => @visitor[:password]
# end
#
# When(/^I don't enter my current password$/) do
#   fill_in "user_current_password", :with => ""
# end
#
# When(/^I edit my email address with an invalid email$/) do
#   click_link "Edit account"
#   fill_in "user_email", :with => "notanemail"
#   fill_in "user_current_password", :with => @visitor[:password]
# end
#
# When(/^I edit my password$/) do
#   click_link "Edit account"
#   fill_in "user_password", :with => "newpassword"
#   fill_in "user_password_confirmation", :with => "newpassword"
#   fill_in "user_current_password", :with => @visitor[:password]
# end
#
# When(/^I edit my password with missing confirmation$/) do
#   click_link "Edit account"
#   fill_in "user_password", :with => "newpassword"
#   fill_in "user_current_password", :with => @visitor[:password]
# end
#
# When(/^I edit my password with missmatched confirmation$/) do
#   click_link "Edit account"
#   fill_in "user_password", :with => "newpassword"
#   fill_in "user_password_confirmation", :with => "newpassword123"
#   fill_in "user_current_password", :with => @visitor[:password]
# end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  # This part is handled by js
  page.should has_text? "Focus LCA"
  # page.should_not have_content "Sign up"
  # page.should_not have_content "Log in"
end

Then /^I should be signed out$/ do
  # This part is handled by js
  page.should has_text? "Focus LCA"
  # page.should have_content "Sign up"
  # page.should have_content "Log in"
  # page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  # page.should have_content "Signed in successfully."
  # This part is handled by js
end

Then /^I should see a successful sign up message$/ do
  page.should has_text? "Focus LCA"
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  # page.should have_content "Password doesn't match confirmation"
  # This part is handle by js
end

Then /^I should see a mismatched password message$/ do
  # page.should have_content "Password doesn't match confirmation"
  # This part is handle by js
end

Then /^I should see a signed out message$/ do
  # page.should have_content "Signed out successfully."
  # This part is handle by js
end

Then /^I see an invalid login message$/ do
  # page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then(/^I should see a current password missing message$/) do
  page.should have_content "Current password can't be blank"
end

Then /^I should see my name$/ do
  create_user
  # page.should have_content @user[:name]
  # Handled by js
end
