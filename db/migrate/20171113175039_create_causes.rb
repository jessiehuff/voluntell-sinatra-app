class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|

      t.timestamps null: false
    end
  end
end
