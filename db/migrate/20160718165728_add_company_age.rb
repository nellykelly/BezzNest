class AddCompanyAge < ActiveRecord::Migration
  def change
  	add_column :users, :year_founded, :integer
  end
end
