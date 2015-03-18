# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[ "Student", "ICF Member" ].each do |name|
  begin
    pt = ProfileType.create!(name: name)
    if name == "ICF Member"
      icf_member = pt.users.build(
        first_name: "Maxim",
        last_name: "Ivanov",
        icf_member_number: "1234567",
        email: "maxshroom@gmail.com",
        password: "please",
        password_confirmation: "please"
      )
      icf_member.save(validate: false)
      icf_member.confirm!
    end
  rescue
    next
  end
end

approval_types = [ "CCE", "ACTP", "ACSTH" ]
languages = ['English', 'French', 'Russian']
program_names  = [
  "Institute for Career Coach",
  "Registered Corporate Coach Training",
  "European Coaching & NLP Certification Program",
  "NeuroPositive Life Coach Certification",
  "Coach Education - Create Development, Results and Motivation",
  "Adler Professional Coaching Certificate"
]
[
  ["Keith's Coach Training", "kpgarrod@gmail.com"],
  ["To the Max", "highbeats@gmail.com"],
  ["Joie de vivre", "gillesmath@me.com"]
].each do |org|
  begin
    tp = TrainingProvider.create!(name: org[0], email: org[1])
  rescue
    next
  end
end

TrainingProvider.each do |p|
  p.training_programs.create!(name: program_names.pop, approval_type: approval_types[1], language: languages.sample)
  p.training_programs.create!(name: program_names.pop, approval_type: approval_types.sample, language: languages.sample)
end

lead = Lead.new(rfp_id: "505f8626164ece0200000007")
lead.save!

AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
#user = User.create! :first_name => 'First', :last_name => 'User1', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
#puts 'New user created: ' << user.name
#user2 = User.create! :first_name => 'Second', :last_name => 'User2', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
#puts 'New user created: ' << user2.name
#user.add_role :admin

