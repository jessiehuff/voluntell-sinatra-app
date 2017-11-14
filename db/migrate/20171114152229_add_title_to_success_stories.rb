class AddTitleToSuccessStories < ActiveRecord::Migration
  def change
      add_column :success_stories, :title, :string
  end
end
