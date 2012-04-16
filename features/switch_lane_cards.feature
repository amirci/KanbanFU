Feature: Drag cards to switch phase
  As a User
  I want to drag the card on the board
  So I can change the phase in the card

@wip @javascript
  Scenario: Drag the card to a working phase
    Given I have a project with phases "Analysis, Development, Review"
    And   I have a card on phase "Analysis"
    When  I display the board
    And   I move the card to phase "Development"
    Then  the card phase should be "Development"
