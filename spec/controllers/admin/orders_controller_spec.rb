require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before { sign_in admin_user }
  let(:order) do
    Faker::UniqueGenerator.clear
    FactoryBot.create(:order)
  end
  let(:valid_attributes) { FactoryBot.attributes_for :order }
  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the order' do
      get :index
      expect(assigns(:orders)).to include(order)
    end

    it 'should render the expected columns' do
      Faker::UniqueGenerator.clear
      c_example = FactoryBot.create(:order)
      get :index
      expect(page).to have_content(c_example.id)
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it 'filter email exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_user_id"]', text: 'User')
      expect(filters_sidebar).to have_css('select[name="q[user_id_eq]"]')
    end
  end

  describe "GET show" do
    before do
      get :show, params: { id: order.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the person' do
      expect(assigns(:order)).to eq(order)
    end
  end
end
