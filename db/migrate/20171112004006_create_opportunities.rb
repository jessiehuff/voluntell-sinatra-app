class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :event
      t.string :date
      t.string :time
      t.string :description
      t.integer :volunteer_id
      t.timestamps null: false
    end
  end
end
