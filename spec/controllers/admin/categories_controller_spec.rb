require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before { sign_in admin_user }
  let(:category) { FactoryBot.create(:category) }
  let(:valid_attributes) { FactoryBot.attributes_for :category }
  let(:invalid_attributes) do
    { email: nil }
  end

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
      c_example = FactoryBot.create(:category)
      get :index
      expect(page).to have_content(c_example.name)
      expect(page).to have_content(c_example.description)
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it 'filter email exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_name"]', text: 'Name')
      expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
    it 'should render the form elements' do
      get :new
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
    end
  end

   describe 'POST create' do
    context 'with valid params' do
      it 'creates a new category' do
        expect { post :create, params: { category: valid_attributes } }.to change(Category, :count).by(1)
      end

      it 'assigns a newly created category as @category' do
        post :create, params: { category: valid_attributes }
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the created category' do
        post :create, params: { category: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_category_path(Category.last))
      end

      it 'should create the category' do
        post :create, params: { category: valid_attributes }
        category = Category.last

        expect(category.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved category as @category' do
        post :create, params: { category: invalid_attributes }
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 'invalid_attributes do not create a Category' do
        expect do
          post :create, params: { category: invalid_attributes }
        end.not_to change(Category, :count)
      end
    end
  end
end
