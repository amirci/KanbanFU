Feature: Projects deletion
  As an API client
  I want to delete a project using the API
  So I can remove it from my list

@wip
  Scenario: Delete a project
    Given I have a project called "Movie Library"
    When  I call the API to delete the project
    Then  the response should indicate the project has been deleted
    And   the project should not exist any more
  