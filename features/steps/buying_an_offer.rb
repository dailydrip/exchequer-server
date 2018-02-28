class Spinach::Features::BuyingAnOffer < Spinach::FeatureSteps
  include CommonSteps::Login
  include CommonSteps::Pages

  step 'I should see make payment button' do
    expect(page).to have_content('Make Payment')
  end

  step 'I should not see the Make Payment button' do
    expect(page).not_to have_content('Make Payment')
  end

  step 'I should see a link to Add a Payment Method' do
    expect(page).to have_content('Add a Payment Method')
  end

  step 'I should see the apply coupon button' do
    expect(page).to have_content('Apply Coupon')
  end

  step 'I should not see the apply coupon button' do
    expect(page).not_to have_content('Apply Coupon')
  end

  step 'I fill out the amount I want to pay' do
    fill_in 'amount', with: 100
  end

  step 'I cannot fill out 1 USD as the amount I want to pay' do
    expect(page).not_to have_selector('amount')
  end

  step 'I click Make Payment' do
    click_on('Make Payment')
  end

  step 'I click on the Purchase link' do
    click_on('Purchase')
  end

  step 'I click Pay full amount' do
    click_on('Pay full amount')
  end

  step 'I can see the Pay full amount button' do
    expect(page).to have_content('Pay full amount')
  end

  step 'I dont see the Make payment button' do
    expect(page).not_to have_content('Make Payment')
  end

  step 'I choose the Payment Method' do
    choose 'payment_method_id_1'
  end

  step 'I click Make Payment in the Choose Payment Method page' do
    expect(page).to have_content('Make Payment')
    expect(page).to have_content('Choose your card')
    click_on('Make Payment')
  end

  step 'I should see a message I just paid for this offer' do
    expect(page).to have_content("You've just paid for this offer")
  end

  step 'I should see a message You cannot pay for this offer anymore' do
    expect(page).to have_content('This offer cannot be paid anymore')
  end

  step 'I should see a message You cannot make a partial payment towards this offer' do
    expect(page).to have_content('You cannot make a partial payment towards this offer')
  end

  step 'I should see the payment form' do
    pending 'check why the spreedly form is not being loaded' do
      fill_in('full_name', with: 'Josh Adams')
      fill_in('card_number', with: '4111111111111111')
      fill_in('cvv', with: '1234')
      fill_in('month', with: '10')
      fill_in('year', with: '2030')
      click_on('Add card')
    end
  end

  step 'I have a Payment Method' do
    user = User.find_by(email: ENV['HIGHLANDS_SSO_EMAIL'])
    user.payment_methods << FactoryGirl.create(:payment_method, token: Rails.application.secrets.payment_method_test_token, user: user)
    user.save!
  end
end
