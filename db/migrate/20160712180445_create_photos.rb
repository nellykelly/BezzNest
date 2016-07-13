class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.belongs_to :post, index: true
      t.timestamps null: false
    end
  end
end
