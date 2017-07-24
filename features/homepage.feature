Feature: Homepage

    As a product designer
    So that I can see features available in the program
    I want to see a homepage with various buttons and functions

Background: Materials and Processes have been added to the database

      Given the following Users exist:
      | name                | username         | password                | email          |
      | John Snow           | user123          | secret_pass1234         | john@snow.com  |


      Given the following Materials exist:
      | title            | category  |
      | Steel            | Metal     |
      | Copper           | Metal     |
      | Aluminum         | Metal     |
      | Concrete         | Ceramic   |
      | Glass            | Ceramic   |
      | Clay             | Ceramic   |
      | Wood             | Wood      |
      | Acids            | Chemicals |
      | Epoxy            | Polymers  |

      Given the following Processes exist:
      | title           | category         | material |
      | Rail            | Transportation   |          |
      | Truck           | Transportation   |          |
      | Boat            | Transportation   |          |
      | Hot Roll        | Manufacturing    | Steel    |
      | Cold Roll       | Manufacturing    | Steel    |
      | Tempering       | Manufacturing    | Steel    |

      Given I am on the loginpage

      And I fill in "username" with "user123"
      And I fill in "password" with "secret_pass1234"
      And I press "Login"

Scenario: Visit the homepage
    Then I should see "Materials"
    And I should see "Manufacturing"
    And I should see "Transport"
    And I should see "Use"
    And I should see "End of Life"
    And I should see "Assembly"
    And I should see "Materials"

Scenario: View Collapsible Materials
   Then I should see "Materials"
   And I choose "Materials" from "library"
   Then I should see "Ceramic"
   And I should see "Chemicals"
   And I should see "Metal"
   And I should see "Polymers"
   And I should see "Wood"
   And I should see "Polymers"

Scenario: View Collapsible Processes
   Then I should see "Manufacturing"
   And I choose "Manufacturing" from "library"
   Then I should see "Ceramic"
   And I should see "Chemicals"
   And I should see "Metal"
   And I should see "Polymers"
   And I should see "Wood"
   And I should see "Polymers"
   And I should see "Hot Roll"
   And I should see "Cold Roll"

Scenario: Add A Material
   Then I should see "Materials"
   And I choose "Materials" from "library"
   Then I should see "Ceramic"
   And I should see "Chemicals"
   And I should see "Metal"
   And I should see "Polymers"
   And I should see "Wood"
   And I should see "Polymers"
   And I should see "Concrete"

Scenario: Logout from Home Page
  Given I am on the homepage
  When I follow "Logout"
  Then I should be on the welcome page
  And I should see "Successfully Logged Out!"
