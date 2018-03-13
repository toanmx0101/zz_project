require 'rails_helper'

describe ProductsController, type: :controller do
  before(:each) do
    Faker::UniqueGenerator.clear
    @product = FactoryBot.create(:product)
  end

  it 'populates an array of products' do
    get :index
    expect(assigns(:products)).to eq([@product])
  end

  it 'renders the :index view' do
    get :index
    expect(response).to have_http_status(:success)
  end

  it 'populates a product' do
    get :show, params: { id: @product.id }
    expect(assigns(:product)).to eq(@product)
  end

  it 'populates a product' do
    get :index, params: { sort_column: 'price', sort_type: 'DESC' }
    FactoryBot.create(:product)
    @sorted_product = Product.all.order(price: :DESC)
    expect(assigns(:products).map(&:id)).to eq(@sorted_product.map(&:id))
  end

  it 'renders the :search view' do
    get :search
    expect(response).to have_http_status(:success)
  end

  # it 'renders the :show view' do
  #   get :show, params: { id: @product.id }
  #   expect(response).to have_http_status(:success)
  # end

  # it 'render the :search product view' do
  #   get :search, params: { q: "Example" }
  #   expect(response).to have_http_status(:success)
  # end

  # it 'search a product' do
  #   get :search, params: { q: "Example" }
  #   products = Product.search_like("Example")
  #   expect(assigns(:products)).to eq(product)
  # end
end
