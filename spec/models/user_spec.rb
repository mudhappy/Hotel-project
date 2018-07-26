require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it 'is invalid without email' do
    user.email = nil
    expect(user).to be_invalid
  end

  context 'when role is employee' do
    let(:user) { FactoryBot.build(:user, :employee) }

    it 'is invalid without enterprise' do
      expect(user).to be_invalid
    end
  end

  context 'when role is admin' do
    let(:user) { FactoryBot.build(:user, :admin) }
    let(:user_w_enterprise) { FactoryBot.build(:user, :admin, :with_enterprise) }

    it 'is valid with enterprise' do
      expect(user).to be_valid
    end

    it 'is valid without enterprise' do
      expect(user).to be_valid
    end
  end
end
