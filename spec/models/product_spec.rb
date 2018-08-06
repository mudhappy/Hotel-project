require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:user) { FactoryBot.create(:user, :admin, :with_enterprise) }
  let(:enterprise) { user.enterprise }
  let(:product) { FactoryBot.build(:product, enterprise_id: enterprise.id) }

  context 'quantity' do
    it 'is invalid if it is greater than zero' do
      product.quantity = 1
      expect(product).to be_valid
    end

    it 'is invalid if it is zero' do
      product.quantity = 0
      expect(product).to be_valid
    end

    it 'is invalid if it is less than zero' do
      product.quantity = -1
      expect(product).to be_invalid
    end
  end
end
