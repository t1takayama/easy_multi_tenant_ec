require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      customer = FactoryBot.create(:customer, tenant_id: tenant.id)
      @order = FactoryBot.build(:order, customer_id: customer.id)
    end

    it 'nameが空だと登録できない' do
      @order.name = nil
      @order.valid?
      STDOUT.puts @order.errors.full_messages
      expect(@order.errors.full_messages).to include("Name can't be blank")
    end

    it 'prefectureが空だと登録できない' do
      @order.prefecture = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'postal_codeが空だと登録できない' do
      @order.postal_code = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'addressが空だと登録できない' do
      @order.address = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Address can't be blank")
    end

    it 'postageが空だと登録できない' do
      @order.postage = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Postage can't be blank")
    end

    it 'postageが0以上のの整数でないと登録できない' do
      @order.postage = -1
      @order.valid?
      STDOUT.puts @order.errors.full_messages
      expect(@order.errors.full_messages).to include('Postage must be greater than or equal to 0')
    end

    it 'billing_amountが空だと登録できない' do
      @order.billing_amount = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Billing amount can't be blank")
    end

    it 'billing_amountが0以上のの整数でないと登録できない' do
      @order.billing_amount = -1
      @order.valid?
      expect(@order.errors.full_messages).to include('Billing amount must be greater than or equal to 0')
    end

    it 'statusの初期値がwaiting_payment' do
      expect(@order.status).to eq "waiting_payment"
    end

    it 'customer_idが空だと登録できない' do
      @order.customer_id= nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Customer can't be blank")
    end
  end
end
