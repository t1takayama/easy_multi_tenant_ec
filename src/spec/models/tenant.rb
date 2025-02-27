require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe '#create' do
    before do
      @tenant = FactoryBot.build(:tenant)
    end

    it 'nameが空だと登録できない' do
      @tenant.name = nil
      @tenant.valid?
      expect(@tenant.errors.full_messages).to include("Name can't be blank")
    end

    it 'domainが空だと登録できない' do
      @tenant.domain = nil
      @tenant.valid?
      expect(@tenant.errors.full_messages).to include("Domain can't be blank")
    end

    it 'statusの初期値がclosed' do
      expect(@tenant.status).to eq 'closed'
    end
  end
end
