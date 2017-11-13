class AddCauseToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :cause, :string
  end
end
