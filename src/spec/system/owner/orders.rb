require 'rails_helper'

RSpec.describe 'Owner::Orders', type: :system do
  let!(:tenant1) { FactoryBot.create(:tenant) }
  let!(:owner) { FactoryBot.create(:owner, tenant_id: tenant1.id) }
  let!(:customer) { FactoryBot.create(:customer, tenant_id: tenant1.id) }
  let!(:order1) { FactoryBot.create(:order, customer_id: customer.id) }
  let!(:order2) { FactoryBot.create(:order, customer_id: customer.id) }
  let!(:other_tenant) { FactoryBot.create(:tenant) }
  let!(:other_customer) { FactoryBot.create(:customer, tenant_id: other_tenant.id) }
  let!(:other_order) { FactoryBot.create(:order, customer_id: other_customer.id) }

  before do
    Capybara.app_host = 'http://localhost'
  end

  context 'ログインしてないとき' do
    it 'ログインページへリダイレクトする' do
      visit owner_orders_path
      expect(current_path).to eq owner_sign_in_path
    end
  end

  context 'ログインしているとき' do
    before do
      visit owner_sign_in_path
      fill_in 'Email', with: owner.email
      fill_in 'Password', with: owner.password
      click_button 'Sign In'
    end

    it '購入履歴一覧が表示される' do
      visit owner_orders_path
      expect(page).to have_content order1.name
      expect(page).to have_content order1.prefecture
      expect(page).to have_content order1.postal_code
      expect(page).to have_content order1.address
      expect(page).to have_content order1.postage
      expect(page).to have_content order1.billing_amount
      expect(page).to have_content order2.name
      expect(page).to have_content order2.prefecture
      expect(page).to have_content order2.postal_code
      expect(page).to have_content order2.address
      expect(page).to have_content order2.postage
      expect(page).to have_content order2.billing_amount
    end

    it '他テナントの購入履歴一覧が表示されない' do
      visit owner_orders_path
      expect(page).not_to have_content other_order.name
      expect(page).not_to have_content other_order.prefecture
      expect(page).not_to have_content other_order.postal_code
      expect(page).not_to have_content other_order.address
    end

    it '購入履歴のstatusが変更できる' do
      visit owner_order_path(order1)
      click_link 'Edit'
      select 'shipped', from: 'Status'
      click_button 'Update Order'
      expect(page).to have_content 'Order was successfully updated.'
      expect(page).not_to have_content other_order.name
      expect(page).not_to have_content other_order.prefecture
      expect(page).not_to have_content other_order.postal_code
      expect(page).not_to have_content other_order.address     
      expect(page).to have_content 'shipped'
    end
  end
end
