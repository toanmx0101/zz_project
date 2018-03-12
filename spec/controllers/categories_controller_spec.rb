require 'rails_helper'

describe CategoriesController do
  it 'populates an array of categories' do
    category = FactoryBot.create(:category)
    get :index
    expect(assigns(:categories)).to eq([category])
  end

  it 'renders the :index view' do
    get :index
    expect(response).to render_template :index
  end
end
