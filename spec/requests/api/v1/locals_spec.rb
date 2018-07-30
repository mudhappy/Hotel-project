require 'rails_helper'

RSpec.describe 'Api::V1::Locals', type: :request do
  let!(:user){ FactoryBot.create(:user, :admin, :with_enterprise) }
  let(:header){ { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
  let(:enterprise){ user.enterprise }
  let(:local_params){ FactoryBot.attributes_for(:local) }
  
  describe 'POST /enterprises/locals' do
    context 'when user is admin' do
      before do
        post(
          api_v1_enterprises_locals_path,
          headers: header,
          params: { local: local_params }
        )
      end
  
      it 'returns enterprise data' do
        data = JSON.parse(response.body)['data']
        expect(data['address']).to eq(local_params[:address])
      end
    end

    context 'when user is employee' do
      let!(:user){ FactoryBot.create(:user, :employee, :with_enterprise) }

      before do
        post(
          api_v1_enterprises_locals_path,
          headers: header,
          params: { local: local_params }
        )
      end

      it 'returns unauthorized status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /enterprises/local/1' do
    let!(:local){ FactoryBot.create(:local, enterprise_id: enterprise.id) }
    before do
      get(
        api_v1_enterprises_local_path(local),
        headers: header
      )
    end

    it 'get returns data' do
      data = JSON.parse(response.body)['data']
      expect(data['address']).to eq(local[:address])  
    end
  end

  describe 'PATCH /enterprises/local/1' do
    let!(:local){ FactoryBot.create(:local, enterprise_id: enterprise.id) }
    before do
      patch(
        api_v1_enterprises_local_path(local),
        params: { local: local_params },
        headers: header
      )
    end

    it 'returns updated data' do
      local.reload
      data = JSON.parse(response.body)['data']
      expect(local['address']).to eq(local_params[:address])
    end
  end

  describe 'GET /enterprises/locals' do
    let!(:list_locals){ FactoryBot.create_list(:local, 3, enterprise_id: enterprise.id) }
    before do
      get(
        api_v1_enterprises_locals_path,
        headers: header
      )
    end

    it 'returns data' do
      data = JSON.parse(response.body)['data']
      expect(user.enterprise.locals.count).to eq(data.count)
    end
  end
end
