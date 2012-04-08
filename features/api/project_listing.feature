Feature: Projects listing
  As as User
  I want to list all my projects using the API
  So I can check which one I want to work with

  Scenario: Listing projects
    Given I have some projects
    When  I call the listing projects API
    Then  the response should contain all existing projects

