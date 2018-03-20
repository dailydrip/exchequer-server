Feature: Applying a Coupon
  In order to apply a Coupon
  As a Logged User with a Coupon code
  I want to go to checkout page and apply my coupon code

  Scenario: User applies a valid coupon code
    Given I am logged in
    And I am on an offer page
    Then I click on the Purchase link
    And I am on the invoice page
    And I have a valid coupon code
    Then I should see the apply coupon button
    And I fill in my coupon code
    And I click Apply Coupon
    Then I should be redirected to the Invoice page
    And I should see a message saying my coupon was applied
    And I should see the coupon applied in my invoice

  Scenario: Coupon codes are case insensitive
    Given I am logged in
    And I am on an offer page
    Then I click on the Purchase link
    And I am on the invoice page
    And I have a valid coupon code for DAILY
    Then I should see the apply coupon button
    And I fill in my coupon code with daily, downcase
    And I click Apply Coupon
    Then I should be redirected to the Invoice page
    And I should see a message saying my coupon was applied
    And I should see the coupon applied in my invoice

  Scenario: User should not see Apply Coupon button after a coupon is applied
    Given I am logged in
    And I am on an offer page
    Then I click on the Purchase link
    And I have a valid coupon code
    Then I should see the apply coupon button
    And I fill in my coupon code
    And I click Apply Coupon
    Then I should be redirected to the Invoice page
    And I should see a message saying my coupon was applied
    And I should see the coupon applied in my invoice
    And I should not see the apply coupon button

  Scenario: User applies an unexistent coupon code
    Given I am logged in
    And I am on an offer page
    Then I click on the Purchase link
    Then I should see the apply coupon button
    And I fill in a wrong coupon code
    And I click Apply Coupon
    Then I should be redirected to the Invoice page
    And I should see a message saying my coupon does not exist

  Scenario: User tries to apply a coupon in a Offer with payments
    Given I am logged in
    And I am on an offer page
    Then I click on the Purchase link
    And I have a valid coupon code
    And I have some payments for this invoice
    And I can see in the invoice some transactions
    Then I should see the apply coupon button
    And I fill in my coupon code
    And I click Apply Coupon
    Then I should be redirected to the Invoice page
    And I should see a message saying I can't apply a coupon after made a payment

  Scenario: User can't use coupons on offers without amounts
    Given I am logged in
    And I am on an offer page without amount
    Then I click on the Purchase link
    And I should not see the apply coupon button

  Scenario: User can use coupons on deferrable offers
    Given I am logged in
    And I am on an offer page
    Then I click on the Purchase link
    And I have a valid coupon code
    And I should see the apply coupon button
