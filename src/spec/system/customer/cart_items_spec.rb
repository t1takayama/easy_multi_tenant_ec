require 'rails_helper'

RSpec.describe 'CartItems', type: :system do
  let!(:tenant) { FactoryBot.create(:tenant) }
  let!(:product) { FactoryBot.create(:product, tenant_id: tenant.id, image: fixture_file_upload('app/assets/images/red.jpeg')) }
  let!(:customer) { FactoryBot.create(:customer, tenant_id: tenant.id) }


  context 'ログインしてないとき' do
    it '商品をカートに入れるとログインページへリダイレクトする' do
      visit cart_items_path(product)
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

    it '商品をカートに入れることができる' do
      visit product_path(product)
      click_button 'Add to Cart'
      expect(page).to have_content 'Succuessfully added to your cart.'
    end

    context 'カートに商品がないとき' do
      it '「Your cart is empty.」が表示される' do
        visit cart_items_path
        expect(page).to have_content 'Your cart is empty.'
      end
    end

    context 'カートに商品があるとき' do
      let!(:cart_item) { FactoryBot.create(:cart_item, customer_id: customer.id, product_id: product.id) }

      it '購入確認画面へ遷移できる' do
        visit cart_items_path
        click_link 'Check'
        expect(current_path).to eq new_order_path
      end

      it '商品を削除できる' do
        visit cart_items_path
        click_link 'Delete', href: cart_item_path(cart_item)
        expect(page).to have_content 'Successfully deleted.'
      end
    end
  end
end
