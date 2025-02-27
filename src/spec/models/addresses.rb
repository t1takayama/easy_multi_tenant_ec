require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      customer = FactoryBot.create(:customer, tenant_id: tenant.id)
      @address = FactoryBot.build(:address, customer_id: customer.id)
    end

    it 'nameが空だと登録できない' do
      @address.name = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Name can't be blank")
    end

    it 'prefectureが空だと登録できない' do
      @address.prefecture = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'postal_codeが空だと登録できない' do
      @address.postal_code = nil
      @address.valid?
      STDOUT.puts @address.errors.full_messages
      expect(@address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'addressが空だと登録できない' do
      @address.address = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Address can't be blank")
    end

    it 'customer_idが空だと登録できない' do
      @address.customer_id= nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Customer can't be blank")
    end
  end
end
