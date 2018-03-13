ActiveAdmin.register Product do
  permit_params :name, :description, :price

  index do
    selectable_column
    id_column
    column('Category', :category, sortable: :category_id)
    column :name
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
      f.input :category_id
      f.input :description
    end
    f.actions
  end
end
