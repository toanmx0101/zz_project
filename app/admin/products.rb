ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :image, :user_id
  index do
    selectable_column
    id_column
    column('Category', :category, sortable: :category_id)
    column :name
    column('User', :user, sortable: :user_id)
    column :description
    column :price
    actions
  end

  filter :name
  filter :price
  filter :category
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category_id
      f.file_field :image
    end
    f.actions
  end
end
