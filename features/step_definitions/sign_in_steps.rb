When /^I sign in with my valid email and password$/ do
  within("form#new_user") do
    fill_in("Email", with: @document.email)
    fill_in("Password", with: "please")
    click_button("Sign in")
  end
end

Then /^I should be on (.*) page$/ do |page_name|
  visit path_to(page_name)
end
