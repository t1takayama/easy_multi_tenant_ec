require 'rails_helper'

RSpec.describe 'Owner::Prodcuts', type: :system do
  let!(:tenant) { FactoryBot.create(:tenant) }
  let!(:owner) { FactoryBot.create(:owner, tenant_id: tenant.id) }

  before do
    Capybara.app_host = 'http://localhost'
  end

  context 'ログインしてないとき' do
    it 'ログインページへリダイレクトする' do
      visit owner_products_path
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

    it '商品が追加できる' do
      visit owner_products_path
      click_link 'Add Product'
      fill_in 'Name', with: 'test1'
      fill_in 'Description', with: 'aaaaaaaa'
      fill_in 'Price', with: 123
      fill_in 'Stock', with: 55
      attach_file 'Image', 'public/icon.png'
      click_button 'Create Product'
      expect(page).to have_content 'Product was successfully created.'
      expect(page).to have_content 'test1'
      expect(page).to have_content 'aaaaaaaa'
      expect(page).to have_content 123
      expect(page).to have_content 55
    end

    context '作成済みの商品が存在するとき' do
      let!(:product) { FactoryBot.create(:product, tenant_id: tenant.id, stock: 10, image: fixture_file_upload('app/assets/images/red.jpeg')) }

      it '商品一覧が表示される' do
        visit owner_products_path
        expect(page).to have_link nil, href: edit_owner_product_path(product)
      end

      it '商品が変更できる' do
        visit owner_products_path
        click_link 'Edit', href: edit_owner_product_path(product)
        fill_in 'Name', with: 'test11'
        fill_in 'Description', with: 'bbbbbb'
        fill_in 'Price', with: 1234
        fill_in 'Stock', with: 56
        attach_file 'Image', 'public/icon.png'
        click_button 'Update Product'
        expect(page).to have_content 'Product was successfully updated.'
        expect(page).to have_content 'Products'
        expect(page).to have_content 'test11'
        expect(page).to have_content 'bbbbbb'
        expect(page).to have_content 1234
        expect(page).to have_content 56
      end

      it '商品が削除できる' do
        visit owner_products_path
        click_link 'Delete', href: owner_product_path(product)
        expect(page).to have_content 'Product was successfully deleted.'
      end
    end
  end
end
