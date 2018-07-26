require 'rails_helper'

RSpec.describe Enterprise, type: :model do
  let!(:enterprise){ FactoryBot.create(:enterprise) }
  let!(:users){ FactoryBot.create_list(:user, 10, enterprise_id: enterprise.id) }

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

  it 'should returns only his users' do
    expect(enterprise.users.count).to eq(10)
  end
end
