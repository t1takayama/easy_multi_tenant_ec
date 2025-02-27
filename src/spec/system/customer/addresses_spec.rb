require 'rails_helper'

RSpec.describe 'Addresses', type: :system do
  let!(:tenant) { FactoryBot.create(:tenant) }
  let!(:customer) { FactoryBot.create(:customer, tenant_id: tenant.id) }

  context 'ログインしてないとき' do
    it '/addressesにアクセスするとログインページにリダイレクトされる' do
      visit addresses_path
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

    context '配送先が登録されていないとき'  do
      it '変更ボタンが表示されない' do
        visit addresses_path
        expect(page).not_to have_content 'Update'
      end

      it '削除ボタンが表示されない' do
        visit addresses_path
        expect(page).not_to have_content 'Delete'
      end

      it '配送先が作成できる' do
        visit addresses_path
        click_link 'Create'
        fill_in 'Name', with: 'name'
        fill_in 'Postal code', with: 'postal code'
        fill_in 'Prefecture', with: 'prefecture'
        fill_in 'Address', with: 'address'
        click_button 'Create Address'
        expect(page).to have_content 'Address was successfully created.'
      end
    end

    context '配送先が登録されているとき'  do
      before do
        FactoryBot.create(:address, customer_id: customer.id)
      end

      it '/addresses/newにアクセスすると/addressesへリダイレクトする' do
        visit new_address_path
        expect(current_path).to eq addresses_path
      end

      it '配送先が変更できる' do
        visit edit_address_path(customer.address.id)
        fill_in 'Name', with: 'name'
        fill_in 'Postal code', with: 'postal code'
        fill_in 'Prefecture', with: 'prefecture'
        fill_in 'Address', with: 'address'
        click_button 'Update'
        expect(page).to have_content 'Address was successfully updated.'
      end

      it '配送先が削除できる' do
        visit addresses_path
        click_link 'Delete'
        expect(page).to have_content 'Address was successfully deleted.'
      end
    end
  end
end
