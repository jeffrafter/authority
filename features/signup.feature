Feature: Signing up
  As an unregistered user
  I want to signup with my details
  So that I can login 
   
  Scenario: Email is not unique 
    Given a registered user with the email "francine@hullaballoo.com" with password "doughnuts" exists
    And I am on the signup page
    When I fill in "Email" with "francine@hullaballoo.com"
    And I fill in "Password" with "ticklemeelmo"
    And I fill in "Verify password" with "ticklemeelmo"
    And I press "Sign up"
    Then the signup form should be shown again
    And I should see "Email has already been taken"
    And I should not be signed in

  Scenario: Password is not valid 
    Given I am on the signup page
    When I fill in "Email" with "francine@yoyoma.com"
    And I fill in "Password" with "ticklemeelmo"
    And I fill in "Verify password" with "doughnuts"
    And I press "Sign up"
    Then the signup form should be shown again
    And I should see "Password doesn't match confirmation"
    And I should not be registered
    And I should not be signed in

  Scenario: Email is unique and password is valid    
    Given I am on the signup page
    When I fill in "Email" with "francine@yoyoma.com"
    And I fill in "Password" with "ticklemeelmo"
    And I fill in "Verify password" with "ticklemeelmo"
    And I press "Sign up"
    Then a new user with the email "francine@yoyoma.com" should be created 
    And an email with the subject "account confirmation" should be sent to me
    And I should see "you will receive an email in the next few minutes."
    And I should not be signed in

  Scenario: User not confirmed
    Given a registered user with the email "francine@hullaballoo.com" with password "doughnuts" exists
    When I confirm my email
    Then I should see "Thanks, your email address has been confirmed"
    And I should be signed in
    And my email should be confirmed

  Scenario: User forgot password
    Given a confirmed user with the email "francine@hullaballoo.com" with password "doughnuts" exists
    When I go to the forgot password page
    And I fill in "Email" with "francine@hullaballoo.com"
    And I press "Reset Password"
    Then an email with the subject "Password reset requested" should be sent to me
    And I should see "instructions for resetting your password"
    And I should not be signed in