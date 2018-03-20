class Spinach::Features::ApplyingACoupon < Spinach::FeatureSteps
  include CommonSteps::Login
  include CommonSteps::Pages

  step 'I fill in my coupon code' do
    fill_in 'coupon', with: 'TEST'
  end

  step 'I fill in a wrong coupon code' do
    fill_in 'coupon', with: 'WrONG'
  end

  step 'I fill in my coupon code with daily, downcase' do
    fill_in 'coupon', with: 'daily'
  end

  step 'I have a valid coupon code' do
    offer = Offer.find(1)
    offer.coupons << FactoryGirl.create(:coupon, name: 'TEST', code: 'test', percent_off: 0.5, offer: offer)
    offer.save!
  end

  step 'I have a valid coupon code for DAILY' do
    offer = Offer.find(1)
    offer.coupons << FactoryGirl.create(:coupon, name: 'TEST', code: 'DAILY', percent_off: 0.5, offer: offer)
    offer.save!
  end

  step 'I should see the apply coupon button' do
    expect(page).to have_content('Apply Coupon')
  end

  step 'I should not see the apply coupon button' do
    expect(page).not_to have_content('Apply Coupon')
  end

  step 'I click Apply Coupon' do
    click_on('Apply Coupon')
  end

  step 'I should see a message saying my coupon was applied' do
    expect(page).to have_content("You've just used your coupon")
  end

  step 'I should see the coupon applied in my invoice' do
    offer = Offer.find(1)
    expect(page).to have_content("#{offer.name} - Coupon")
  end

  step 'I should see a message saying my coupon does not exist' do
    expect(page).to have_content('This coupon does not exist')
  end

  step 'I have some payments for this invoice' do
    user = User.find_by(email: ENV['HIGHLANDS_SSO_EMAIL'])
    invoice = Invoice.find_by(user: user, offer: Offer.find(1))
    invoice.payments << FactoryGirl.create(:payment, amount: 1, invoice: invoice)
    invoice.save!
    visit "/invoices/#{invoice.id}"
  end

  step 'I can see in the invoice some transactions' do
    expect(page).to have_css('.payments')
  end

  step 'I click on the Purchase link' do
    click_on('Purchase')
  end

  step "I should see a message saying I can't apply a coupon after made a payment" do
    expect(page).to have_content("You can't apply a coupon after you've made a payment")
  end
end
