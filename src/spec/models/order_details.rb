require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      image = fixture_file_upload('app/assets/images/red.jpeg')
      product = FactoryBot.create(:product, tenant_id: tenant.id, image: image)
      customer = FactoryBot.create(:customer, tenant_id: tenant.id)
      order = FactoryBot.create(:order, customer_id: customer.id)
      @order_detail = FactoryBot.build(:order_detail, order_id: order.id, product_id: product.id)
    end

    it 'priceが空だと登録できない' do
      @order_detail.price = nil
      @order_detail.valid?
      expect(@order_detail.errors.full_messages).to include("Price can't be blank")
    end

    it 'priceが0以上の整数でないと登録できない' do
      @order_detail.price = -1
      @order_detail.valid?
      expect(@order_detail.errors.full_messages).to include('Price must be greater than or equal to 0')
    end

    it 'quantityが空だと登録できない' do
      @order_detail.quantity = nil
      @order_detail.valid?
      expect(@order_detail.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'quantityが0以上のの整数でないと登録できない' do
      @order_detail.quantity = -1
      @order_detail.valid?
      expect(@order_detail.errors.full_messages).to include('Quantity must be greater than or equal to 0')
    end

    it 'product_idが空だと登録できない' do
      @order_detail.product_id = nil
      @order_detail.valid?
      expect(@order_detail.errors.full_messages).to include("Product can't be blank")
    end

    it 'order_idが空だと登録できない' do
      @order_detail.order_id = nil
      @order_detail.valid?
      expect(@order_detail.errors.full_messages).to include("Order can't be blank")
    end
  end
end
