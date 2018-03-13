require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before { sign_in admin_user }
  let(:category) { FactoryBot.create(:category) }
  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the category' do
      get :index
      expect(assigns(:categories)).to include(category)
    end

    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(category.name)
      expect(page).to have_content(category.description)
      expect(page).to have_content(category.sign_in_count)
      expect(page).to have_content(category.created_at.strftime('%B %-d, %Y %H:%M'))
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it 'filter email exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_name"]', text: 'Name')
      expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
    end
  end
end
