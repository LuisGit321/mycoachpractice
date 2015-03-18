Given /^I am not signed in$/ do
  step %{I am not logged in}
end

And /^I am on the (.*) page$/ do |page_name|
  visit path_to(page_name)
end

When /^I choose to sign up as (?:an|a) (.*)$/ do |profile_type|
  within("form#new_user") do
    case profile_type
    when "ICF member"
      select("ICF Member", from: "Membership type")
    when "registered student on an Accredited Coach Training Program"
      select("Student", from: "Membership type")
    end
  end
end

When /^I sign up with the following:$/ do |table|
  fields = table.hashes.first
  within("form#new_user") do
    fill_in("Last name", with: fields[:last_name])
    fill_in("Email", with: fields[:email])
    fill_in("ICF membership number", with: fields[:icf_member_number]) if fields[:icf_member_number].present?
    select(fields[:training_program], from: "Training program") if fields[:training_program].present?
    if fields[:graduation_date].present?
      #select_date(fields[:graduation_date], from: "Graduation date")
      fill_in("Graduation date", with: fields[:graduation_date])
    end
  end
  step %{I fill in other fields}
end

And /^I choose the training program with name: "(.*?)"$/ do |program_name|
  within("form#new_user") do
    select(program_name, from: "Training program")
  end
end

And /^I fill in other fields$/ do
  within("form#new_user") do
    fill_in("First name", with: "Keith")
    fill_in("Password", with: "testsword1")
    fill_in("Password confirmation", with: "testsword1")
    click_button("Sign up!")
  end
end

And /^I log out$/ do
  click("Logout")
end

Then /^I should see "(.*?)"$/ do |message|
  page.should have_content(message)
end
