require 'rails_helper'

RSpec.describe Enterprise, type: :model do
  let!(:user){ FactoryBot.create(:user) }
  let(:enterprise){ FactoryBot.build(:enterprise, user_id: user.id) }

  it 'is invalid with name' do
    enterprise.name = nil
    expect(enterprise).to be_invalid
  end

  it 'is invalid with ruc' do
    enterprise.ruc = nil
    expect(enterprise).to be_invalid
  end

  it 'is valid if ruc have 11 digits' do
    enterprise.ruc = Faker::Number.number(10)
    expect(enterprise).to be_invalid
    
    enterprise.ruc = Faker::Number.number(12)
    expect(enterprise).to be_invalid

    enterprise.ruc = Faker::Number.number(11)
    expect(enterprise).to be_valid
  end

  it 'is valid if have a owner user' do
    enterprise.user_id = nil 
    expect(enterprise).to be_invalid
  end
end
