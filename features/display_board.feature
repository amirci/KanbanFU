Feature: Display cards on the board
  As a User
  I want to load the project board
  So I can see the the cards in the phases
  
  Scenario: Display project phases 
    Given I have a project "Movie Site" with cards
    When  I go to the board
    Then  I should see all the project phases
