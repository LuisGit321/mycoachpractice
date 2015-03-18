Given /^the following (.*) exist$/ do |models, table|
  table.hashes.each do |hash|
    FactoryGirl.create(models.singularize, hash)
  end
end

Given /^(?:a|an) (.*) exists with (.*)$/ do |model, attributes|
  attr_hash = Hash.new attributes
  @document = FactoryGirl.create(model.to_sym, attr_hash)
  @document.should be
end

Then /^(?:a|the) (.*) should exist with (.*)$/ do |model, attributes|
  record = model.classify.constantize.where(attributes)
  record.should be
end

Then /^(\d+) email should be delivered to "(.*?)"$/ do |count, email|
  Devise::Mailer.should_receive(:confirmation_instructions)
end

And /^(?:a|the) (.*) should not exist with (.*)$/ do |model, attributes|
  model.classify.constantize.where(attributes).count.should == 0
end
