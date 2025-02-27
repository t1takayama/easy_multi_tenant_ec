require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      product = FactoryBot.create(:product, tenant_id: tenant.id)
      customer = FactoryBot.create(:customer, tenant_id: tenant.id)
      @cart_item = FactoryBot.build(:cart_item, customer_id: customer.id, product_id: product.id)
    end

    it 'quantity空だと登録できない' do
      @cart_item.quantity = nil
      @cart_item.valid?
      expect(@cart_item.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'customer_idが空だと登録できない' do
      @cart_item.customer_id= nil
      @cart_item.valid?
      expect(@cart_item.errors.full_messages).to include("Customer can't be blank")
    end

    it 'product_idが空だと登録できない' do
      @cart_item.product_id= nil
      @cart_item.valid?
      expect(@cart_item.errors.full_messages).to include("Product can't be blank")
    end
  end
end
