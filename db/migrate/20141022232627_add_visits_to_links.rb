class AddVisitsToLinks < ActiveRecord::Migration
  def change
    add_column :links, :visits, :integer, default: 0, null: false
  end
end
