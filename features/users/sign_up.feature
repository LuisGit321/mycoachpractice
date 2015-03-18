Feature: Sign up
  In order to set up my coach profile
  As an unregistered user
  I want to be able to sign up


  Background:
    Given the following profile_types exist
      | name       |
      | Student    |
      | ICF Member |
    And the following training_programs exist
      | name         | approval_type |
      | Career coach | ACTP          |
    And I am not signed in
    And I am on the sign up page

  @icf_members
  Scenario: User signs up as an ICF member with valid data
    When I choose to sign up as an ICF member
    And I sign up with the following:
      | last_name | email                            | icf_member_number |
      | Garrod    | keith@opportunityindiversity.com | 9026152           |
    Then I should see "You have signed up successfully. Please confirm by following the link sent to your email." message
    And a user should exist with email: "keith@opportunityindiversity.com"
    And "keith@opportunityindiversity.com" should receive 1 email

  @icf_members
  Scenario Outline: User signs up as an ICF member with invalid ICF credentials
    When I choose to sign up as an ICF member
    And I sign up with the following:
      | last_name      | email   | icf_member_number   |
      | <last_name>    | <email> | <icf_member_number> |
    Then I should see "<message>" message

    Examples:
      | last_name | icf_member_number | email                            | message                                          |
      | Dorrag    | 9026152           | keith@opportunityindiversity.com | Last name cannot be verified with ICF directory. |
      | Garrod    | 9026152           | example@example.com              | Email cannot be verified with ICF directory.     |
      | Garrod    | 5000000           | keith@opportunityindiversity.com | Icf membership number not found in ICF directory.    |

  @students
  Scenario: User signs up as a registered student with valid credentials
    When I choose to sign up as a registered student on an Accredited Coach Training Program
    And I sign up with the following:
      | last_name      | email              | training_program         | graduation_date   |
      | Garrod         | kpgarrod@gmail.com | Some Name - Career coach | 10/09/2013 |
    Then I should see "You have signed up successfully. Please confirm by following the link sent to your email." message
    And a user should exist with email: "kpgarrod@gmail.com"
    #And 1 email should be sent to the MyCoachPractice administrator

  @students
  Scenario: User signs up as a registered student with invalid specific data
    When I choose to sign up as a registered student on an Accredited Coach Training Program
    And I sign up with the following:
      | last_name | email              |
      | Garrod    | kpgarrod@gmail.com |
    Then I should see "Training program can't be blank" message
    And I should see "Graduation date can't be blank" message
    And a user should not exist with email: "kpgarrod@gmail.com"

