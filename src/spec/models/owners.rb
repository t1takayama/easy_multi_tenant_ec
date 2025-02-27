require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      @owner = FactoryBot.build(:owner, tenant_id: tenant.id)
    end

    it 'emailが空だと登録できない' do
      @owner.email = nil
      @owner.valid?
      expect(@owner.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合は登録できない' do
      @owner.save
      another_owner = FactoryBot.build(:owner)
      another_owner.email = @owner.email
      another_owner.valid?
      expect(another_owner.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空だと登録できない' do
      @owner.password = nil
      @owner.valid?
      expect(@owner.errors.full_messages).to include("Password can't be blank")
    end

    it 'password_digestが空だと登録できない' do
      @owner.password_digest = nil
      @owner.valid?
      expect(@owner.errors.full_messages).to include("Password can't be blank")
    end

    it 'tenant_idが空だと登録できない' do
      @owner.tenant_id = nil
      @owner.valid?
      expect(@owner.errors.full_messages).to include("Tenant can't be blank")
    end
  end
end
