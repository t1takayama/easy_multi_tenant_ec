require 'rails_helper'

RSpec.describe 'Admin::Owners', type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:tenant) { FactoryBot.create(:tenant) }

  before do
    Capybara.app_host = 'http://localhost'
  end

  context 'ログインしてないとき' do
    it 'ログインページへリダイレクトする' do
      visit admin_tenant_owners_path(tenant.id)
      expect(current_path).to eq admin_sign_in_path
    end
  end

  context 'ログインしているとき' do
    before do
      visit admin_sign_in_path
      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: admin_user.password
      click_button 'Sign In'
    end

    it 'オーナーが追加できる' do
      visit admin_tenants_path
      click_link tenant.name
      click_link 'Add Owner'
      fill_in 'Email', with: 'owner@example.com'
      fill_in 'Password', with: 'passw0rd'
      fill_in 'Password confirmation', with: 'passw0rd'
      click_button 'Create Owner'
      expect(page).to have_content 'Owner was successfully created.'
      expect(page).to have_content 'Owner'
      expect(page).to have_content 'owner@example.com'
    end

    context 'オーナーが存在するとき' do
      let!(:owner1) { FactoryBot.create(:owner, tenant_id: tenant.id) }
      let!(:owner2) { FactoryBot.create(:owner, tenant_id: tenant.id) }

      it 'オーナー一覧が表示される' do
        visit admin_tenants_path
        click_link tenant.name
        expect(page).to have_link owner1.email
        expect(page).to have_link owner2.email
      end

      it 'オーナーの情報が変更できる' do
        visit admin_tenants_path
        click_link tenant.name
        click_link owner1.email
        click_link 'Edit Owner'
        fill_in 'Email', with: 'owner100@example.com'
        fill_in 'Password', with: 'passw0rd'
        fill_in 'Password confirmation', with: 'passw0rd'
        click_button 'Update Owner'
        expect(page).to have_content 'Owner was successfully updated.'
        expect(page).to have_content 'Owner'
        expect(page).to have_content 'owner100@example.com'
      end
    end
  end
end
