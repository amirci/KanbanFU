Feature: Projects creation
  As as User
  I want to create a project using the API
  So I can start adding cards to it

  Scenario: Creating a project
    Given I post to "/projects" with:
      | name              | description |
      | Blazing Saddles   | To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary.|
    When I call API "/projects"
    Then the response should be a collection of "projects" with:
      | id | name              | description |
      | 1  | Blazing Saddles   | To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary.|
  
