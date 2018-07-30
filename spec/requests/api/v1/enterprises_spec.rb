require 'rails_helper'

RSpec.describe 'Api::V1::Enterprises', type: :request do
  let(:header) { { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
  let(:enterprise_params) { FactoryBot.attributes_for(:enterprise) }

  describe 'POST /enterprises' do
    context 'when user is admin' do
      let!(:user) { FactoryBot.create(:user, :admin) }

      before do
        post(
          api_v1_enterprises_path,
          params: { enterprise: enterprise_params },
          headers: header
        )
      end

      it 'return a 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'can create only one enterprise' do
        expect{
          post(
            api_v1_enterprises_path,
            params: { enterprise: enterprise_params },
            headers: header
          )
        }.to_not change{ Enterprise.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match(/error/)
      end

      it 'associate the enterprise after creating it' do
        user.reload
        data = JSON.parse(response.body)['data']
        expect(user.enterprise.name).to eq(data['name'])
      end
    end

    context 'when user is employee' do
      let!(:user) { FactoryBot.create(:user, :employee, :with_enterprise) }

      before do
        post(
          api_v1_enterprises_path,
          params: { enterprise: enterprise_params },
          headers: header
        )
      end
        
      it 'returns a 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a error message' do
        expect(response.body).to match(/error/)
      end
    end

    context 'when user not exists' do
      let!(:user) { FactoryBot.build(:user) }

      before do
        post(
          api_v1_enterprises_path,
          params: { enterprise: enterprise_params },
          headers: header
        )
      end

      it 'returns a 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end

    end

  end

  describe 'PATCH /enterprises/:id' do
    let!(:user) { FactoryBot.create(:user, :admin, :with_enterprise) }
    let(:enterprise) { user.enterprise }

    context 'when user is an admin' do

      before do
        patch(
          api_v1_enterprises_path(id: enterprise.id),
          params: { enterprise: enterprise_params },
          headers: header
        )
      end

      it 'returns 201 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the enterprise data updated' do
        enterprise.reload
        data = JSON.parse(response.body)['data']
        expect(enterprise['name']).to eq(enterprise_params[:name])
      end
    end


    context 'when user is an employee' do
      let!(:user) { FactoryBot.create(:user, :employee, :with_enterprise) }

      before do
        patch(
          api_v1_enterprises_path(id: enterprise.id),
          params: { enterprise: enterprise_params },
          headers: header
        )
      end

      it 'returns 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a error message' do
        expect(response.body).to match(/error/)
      end
    end
  end

  describe 'GET /enterprise/:id' do
    let!(:user) { FactoryBot.create(:user, :employee, :with_enterprise) }
    let(:header) { { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
    let(:enterprise) { user.enterprise }

    context 'when user belong to the enterprise' do
      before do
        get(
          api_v1_enterprises_path,
          headers: header
        )
      end

      it 'returns enterprise data' do
        data = JSON.parse(response.body)['data']
        expect(data['name']).to eq(enterprise.name) 
      end
    end

    # context 'when user no belong to enterprise' do
    #   let!(:other_enterprise) { FactoryBot.create(:enterprise) }
    #   before do
    #     get(
    #       api_v1_enterprises_path(id: other_enterprise.id),
    #       headers: header
    #     )
    #   end

    #   it 'returns 401 status code' do
    #     expect(response).to have_http_status(:unauthorized)
    #   end
    # end
  end
end
