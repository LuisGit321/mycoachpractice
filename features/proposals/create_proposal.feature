Feature: Coach creates Proposal
  In order to respond to a Lead
  As a Coach
  I create a Proposal

  Background:
    Given I am an authenticated icf member
    And the following lead exist
      | coachee_representing_issue | coachee_name | rfp_id |
      | Representing issue         | John Smith   | 1r345t |
    And no proposals exist

  Scenario: User creates proposal using default template
    When I go to the leads index page
    And I choose to send proposal for the lead
    Then I should be on the new proposal page
    When I fill in the following:
      | Export_format | Start from date | End date   | Coaching media | After hours availability | Number of sessions | Session duration | Mediation period |
      | pdf           | 28/10/2012      | 28/04/2012 | Lecture        | available                | 5                  | 4                |                  |
    Then I should be on propasals page
    And 1 proposal should exist

  #  Scenario: I have already customised my Proposal Template
  #
  #  Scenario: I want to use a customised Proposal Template but I have not yet customised my Proposal Template
  #
  #  Scenario: I want to use the standard Template
