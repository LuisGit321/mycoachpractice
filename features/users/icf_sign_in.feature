Feature: Icf member sign in
  In order to get access to protected sections of the site
  As a registered icf member
  I want to sign in

  Background:
    Given an icf_member exists with email: "keith@opportunityindiversity.com"
    And I am not signed in
    And I am on the sign in page

  Scenario: Icf member signs in with valid data
    When I sign in with my valid email and password
    Then I should see "Signed in successfully" message
    And I should be on my profiles page

