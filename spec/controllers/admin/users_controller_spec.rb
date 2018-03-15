require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before { sign_in admin_user }
  let!(:user) {
    FactoryBot.create(:user) 
  }
  let!(:order) {
    FactoryBot.create(:order, user_id: user.id) 
  }
  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the users' do
      get :index
      expect(assigns(:users)).to include(user)
    end

    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.current_sign_in_at)
      expect(page).to have_content(user.sign_in_count)
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it 'filter email exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_email"]', text: 'Email')
      expect(filters_sidebar).to have_css('input[name="q[email_contains]"]')
    end
  end

  describe "GET show" do
    before do
      get :show, params: { id: user.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the person' do
      expect(assigns(:user)).to eq(user)
    end
    it 'should render the expected columns' do
      get :show, params: { id: user.id }
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.created_at.strftime("%B %e, %Y %H:%I"))
      expect(page).to have_content(order.total_price)
    end
  end
end
