require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let!(:tenant) { FactoryBot.create(:tenant) }
  let!(:customer) { FactoryBot.create(:customer, tenant_id: tenant.id) }
  let!(:product) { FactoryBot.create(:product, stock: 100, tenant_id: tenant.id, image: fixture_file_upload('app/assets/images/red.jpeg')) }

  context 'ログインしていないとき' do
    it 'ログイン画面へリダイレクトする' do
      visit new_order_path
      expect(current_path).to eq sign_in_path
    end
  end

  context 'ログインしているとき' do
    before do
      visit sign_in_path
      fill_in 'Email', with: customer.email
      fill_in 'Password', with: customer.password
      click_button 'Sign In'
    end

    context 'カートに商品が入っていないとき' do
      it '商品一覧へリダイレクトする' do
        visit new_order_path
        expect(current_path).to eq root_path
      end
    end

    context 'カートに商品が入っているとき' do
      let!(:cart_item) { FactoryBot.create(:cart_item, quantity: 2, product_id: product.id, customer_id: customer.id) }

      context '配送先が設定されていないとき' do
        it '配送先設定のリンクと誘導するメッセージが表示される' do
          visit new_order_path
          expect(page).to have_content 'Please set your shipping address.'
          expect(page).to have_link 'Set shipping address.'
        end
      end

      context '配送先が設定されているとき' do
        let!(:address) { FactoryBot.create(:address, customer_id: customer.id) }

        it '商品が購入できること' do
          visit new_order_path
          click_button 'Purchase'
          expect(current_path).to eq success_orders_path
        end
      end
    end
  end
end
