require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  let!(:user) { FactoryBot.create(:user, :admin, :with_enterprise) }
  let(:enterprise) { user.enterprise }
  let(:header) { { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
  let!(:create_list) { FactoryBot.create_list(:product, 10, enterprise_id: enterprise.id) }
  let(:product) { create_list.first }
  let(:product_params) { FactoryBot.attributes_for(:product, enterprise_id: enterprise.id) }

  describe 'GET /enterprises/products' do
    before do
      get(
        api_v1_enterprises_products_path,
        headers: header
      )
    end

    it 'returns products collection' do
      data = JSON.parse(response.body)['data']
      expect(data.count).to eq(enterprise.products.count)
    end
  end

  describe 'POST /enterprises/products' do
    before do
      post(
        api_v1_enterprises_products_path,
        params: { product: product_params },
        headers: header
      )
    end

    it 'return enterprise data' do
      data = JSON.parse(response.body)['data']
      expect(data['dni']).to eq(product_params[:dni]) 
    end
  end

  describe 'PATCH /enterprises/products/:id' do
    before do
      patch(
        api_v1_enterprises_product_path(id: product.id),
        params: { product: product_params },
        headers: header
      )
    end

    it 'returns product updated' do
      product.reload
      data = JSON.parse(response.body)['data']
      expect(data['dni']).to eq(product[:dni])
    end
  end
end
