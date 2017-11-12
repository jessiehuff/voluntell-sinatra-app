class CreateSuccessStories < ActiveRecord::Migration
  def change
    create_table :success_stories do |t|
      t.string :author
      t.string :content
      t.integer :volunteer_id
      t.timestamps null: false
    end
  end
end
