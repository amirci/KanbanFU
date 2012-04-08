Feature: Projects creation
  As as User
  I want to create a project using the API
  So I can start adding cards to it

  @wip
  Scenario: Creating a project
    Given I create a new project using the API
    When  I call the listing projects API
    Then  the response should include the new project
  
