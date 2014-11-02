class AddPublicToLinks < ActiveRecord::Migration
  def change
    add_column :links, :public, :boolean, null: false, default: false
  end
end
