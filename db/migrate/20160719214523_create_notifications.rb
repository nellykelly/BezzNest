class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.boolean :viewed
    	t.integer :topic_id
    	t.string :contents
    	t.string :link
    	t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
