require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    let(:user) { FactoryBot.build(:user) }

    it 'is invalid without email' do
      user.email = nil
      expect(user).to be_invalid
    end
  end

  describe 'role' do
    let(:employee) { FactoryBot.build(:user, :without_enterprise) }
    let(:admin) { FactoryBot.build(:user, :without_enterprise, role: 'admin') }

    it 'employee is invalid without enterprise' do
      expect(employee).to be_invalid
    end

    it 'admin is valid without enterprise' do
      expect(admin).to be_valid
    end
  end
end
