require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    before do
      tenant = FactoryBot.create(:tenant)
      @product = FactoryBot.build(:product, tenant_id: tenant.id)
      @product.image = fixture_file_upload('app/assets/images/red.jpeg')
    end

    it 'nameが空だと登録できない' do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'descriptionが空だと登録できない' do
      @product.description = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Description can't be blank")
    end

    it 'priceが空だと登録できない' do
      @product.price = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'priceが0以上の整数でないと登録できない' do
      @product.price = -1
      @product.valid?
      expect(@product.errors.full_messages).to include('Price must be greater than or equal to 0')
    end

    it 'stockが空だと登録できない' do
      @product.stock = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Stock can't be blank")
    end

    it 'stockが0以上のの整数でないと登録できない' do
      @product.stock = -1
      @product.valid?
      expect(@product.errors.full_messages).to include('Stock must be greater than or equal to 0')
    end

    it 'tenant_idが空だと登録できない' do
      @product.tenant_id = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Tenant can't be blank")
    end

    it 'imageが空だと登録できない' do
      @product.image = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Image can't be blank")
    end
  end
end
