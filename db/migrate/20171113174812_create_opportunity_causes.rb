class CreateOpportunityCauses < ActiveRecord::Migration
  def change
    create_table :opportunity_causes do |t|
      t.integer :opportunity_id
      t.integer :cause_id
    end
  end
end
