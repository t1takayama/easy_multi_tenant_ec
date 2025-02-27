require 'rails_helper'

RSpec.describe 'Prodcuts', type: :system do
  let!(:tenant) { FactoryBot.create(:tenant) }
  let!(:customer) { FactoryBot.create(:customer, tenant_id: tenant.id) }
  let!(:product) { FactoryBot.create(:product, tenant_id: tenant.id, stock: 10, image: fixture_file_upload('app/assets/images/red.jpeg')) }
  let!(:non_stock_product) { FactoryBot.create(:product, tenant_id: tenant.id, stock: 0, image: fixture_file_upload('app/assets/images/red.jpeg')) }

  it '商品一覧が表示される' do
    visit root_path
    expect(page).to have_link nil, href: product_path(product)
    expect(page).to have_link nil, href: product_path(non_stock_product)
  end

  context '商品詳細画面にアクセスしたとき' do
    context '商品の在庫がないとき' do
      it '「Add to Cart」ボタンが表示されず「Out of Stock」が表示される' do
        visit product_path(non_stock_product)
        expect(page).not_to have_button 'Add to Cart'
        expect(page).to have_content 'Out of Stock'
      end
    end

    context '商品の在庫があるとき' do
      it '「Add to Cart」ボタンが表示される' do
        visit product_path(product)
        expect(page).to have_button 'Add to Cart'
      end
    end
  end
end
