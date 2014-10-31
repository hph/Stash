class AddTimestampToTrackings < ActiveRecord::Migration
  def change
    add_column :trackings, :created_at, :datetime
  end
end
