Feature: Projects deletion
  As an API client
  I want to delete a project using the API
  So I can remove it from my list

  Scenario: Delete a project
    Given I have a project "Movie Library"
    When  I call the delete the project API
    Then  the response should indicate the project has been deleted
    And   the project should not exist any more
  
