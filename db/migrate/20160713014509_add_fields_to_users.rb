class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :location, :string
  	add_column :users, :company_type, :string
  	add_column :users, :size_catagory, :integer
  	add_column :users, :prices, :integer
  end
end
