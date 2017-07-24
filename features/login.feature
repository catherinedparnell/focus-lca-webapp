Feature: Login a User

    As a product designer
    So that I can see my projects
    I want to be able to login.

Background:

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

      Given the following Users exist:
      | name                | username         | password                | email          |
      | John Snow           | snowman          | secret_pass1234         | john@snow.com  |

Scenario: Visit the Welcome Page
    Given I am on the welcomepage
    Then I should see "Login"
    And I should see "Signup"
    And I should see "Focus LCA"

Scenario: Visit Login Page

   Given I am on the loginpage
   Then I fill in "username" with "user123"
   And I fill in "password" with "secet_pass1234"

Scenario: Visit Login Page

   And I am on the loginpage

   Then I fill in "username" with "snowman"
   And I fill in "password" with "secet_pass1234"
   And I press "Login"

   Then I should see "Library"

Scenario: Visit Signup Page
   Given I am on the signuppage
   And I fill in "username" with "user1234"
   And I fill in "name" with "John Snow"
   And I fill in "email" with "john@knightswatch.net"
   And I fill in "password" with "abcd"
   And I fill in "confirm_password" with "abcd"

Scenario: Signup a New User
   Given I am on the signuppage
   And I fill in "username" with "user1234"
   And I fill in "name" with "John Snow"
   And I fill in "email" with "john@knightswatch.net"
   And I fill in "password" with "abcd"
   And I fill in "confirm_password" with "abcd"
   And I press "Signup"

   Then I should see "Library"

Scenario: Signup Errors
   Scenario: Same Username
      Given I am on the signuppage
      And I fill in "username" with "snowman"
      And I fill in "name" with "John Snow2"
      And I fill in "email" with "john2@knightswatch.net"
      And I fill in "password" with "abcd"
      And I fill in "confirm_password" with "abcd"
      And I press "Signup"

      Then I should see "Error"
      And I should not see "Library"

   Scenario: Same email
      Given I am on the signuppage
      And I fill in "username" with "otheruser"
      And I fill in "name" with "John Snow"
      And I fill in "email" with "john@snow.com"
      And I fill in "password" with "abcd"
      And I fill in "confirm_password" with "abcd"
      And I press "Signup"

      Then I should see "Error"
      And I should not see "Library"

   Scenario:
      Given I am on the loginpage
      And I fill in "username" with "someRandom"
      And I fill in "password" with "whatever"
      And I press "Login"
      Then I should be on the login page
      And I should see "No Login Found, Try Again!"
