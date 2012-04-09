Feature: Cards API
  As as User
  I want to use the API to manage cards
  to administrate cards operations

  Scenario: Listing cards for a project
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I get all the cards for project 1 using the API
    Then the response should be a collection of "cards" with:
      | id | title            | description                       | 
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate | 
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    | 
      | 3  | Take the town    | Make everybody sell their houses  | 

  Scenario: Get detail of a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I get card 2 for project 1 using the API
    Then the response should be a "card" with:
      | id | title            | description                       |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |

  Scenario: Creating a card
    Given I post to "/cards" for project "1" with:
      | title                 | description                       |
      | Kill the Sheriff      | Make the town kill the Sheriff    |
    When I get all the cards for project 1 using the API
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Kill the Sheriff | Make the town kill the Sheriff    |

  Scenario: Updating a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    And I put to "/cards" for project "1" and card "1" with:
      | title                 | description                       |
      | Find a Deputy         | Get a Deputy for the Sheriff      |
    When I get all the cards for project 1 using the API
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Find a Deputy    | Get a Deputy for the Sheriff      |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |

  Scenario: Deleting a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    And I delete card "3" for project "1"
    When I get all the cards for project 1 using the API
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
