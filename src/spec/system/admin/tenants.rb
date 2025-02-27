require 'rails_helper'

RSpec.describe 'Admin::Tenants', type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    Capybara.app_host = 'http://localhost'
  end

  context 'ログインしてないとき' do
    it 'ログインページへリダイレクトする' do
      visit admin_tenants_path
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

    it 'テナントが追加できる' do
      visit new_admin_tenant_path
      fill_in 'Name', with: 'tenant101'
      fill_in 'Domain', with: 'tenant101.example.com'
      click_button 'Create Tenant'
      expect(page).to have_content 'Tenant was successfully created.'
      expect(page).to have_content 'tenant101'
      expect(page).to have_content 'closed'
      expect(page).to have_content 'tenant101.example.com'
    end

    context 'テナントが存在するとき' do
      let!(:tenant1) { FactoryBot.create(:tenant, name: 'tenant1') }
      let!(:tenant2) { FactoryBot.create(:tenant, name: 'tenant2') }

      it 'テナント一覧が表示される' do
        visit admin_tenants_path
        expect(page).to have_link tenant1.name, href: admin_tenant_path(tenant1)
        expect(page).to have_link tenant2.name, href: admin_tenant_path(tenant2)
      end

      it 'テナントの情報が変更できる' do
        visit admin_tenants_path
        click_link tenant1.name
        click_link 'Edit Tenant'
        fill_in 'Name', with: 'tenant1010'
        choose 'tenant_status_normal'
        fill_in 'Domain', with: 'tenant1010.example.com'
        click_button 'Update Tenant'
        expect(page).to have_content 'Tenant was successfully updated.'
        expect(page).to have_content 'tenant1010'
        expect(page).to have_content 'normal'
        expect(page).to have_content 'tenant1010.example.com'
      end
    end
  end
end
