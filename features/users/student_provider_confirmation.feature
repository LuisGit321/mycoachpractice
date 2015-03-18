Feature: Student Provider Confirmation
  In order to verify myself as a real student of a selected course
  As a student
  I want my credentials confirmed by the course provider

  Background:
    Given the following profile_types exist
    | name         | approval_type |
    | Career coach | ACTP          |

    Given the following user exists:
      | last_name | email | training
  Scenario: Student 
