require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      @customer = FactoryBot.build(:customer, tenant_id: tenant.id)
    end

    it 'nameが空だと登録できない' do
      @customer.name = nil
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空だと登録できない' do
      @customer.email = nil
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合登録できない' do
      @customer.save
      another_customer = FactoryBot.build(:customer)
      another_customer.email = @customer.email
      another_customer.valid?
      expect(another_customer.errors.full_messages).to include("Email has already been taken")
    end

    it 'passwordが空だと登録できない' do
      @customer.password = nil
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Password can't be blank")
    end

    it 'password_digestが空だと登録できない' do
      @customer.password_digest = nil
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Password can't be blank")
    end

    it 'tenant_idが空だと登録できない' do
      @customer.tenant_id = nil
      @customer.valid?
      expect(@customer.errors.full_messages).to include("Tenant can't be blank")
    end
  end
end
