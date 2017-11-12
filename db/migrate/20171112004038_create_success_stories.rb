class CreateSuccessStories < ActiveRecord::Migration
  def change
    create_table :success_stories do |t|

      t.timestamps null: false
    end
  end
end
