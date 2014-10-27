class FixIndexes < ActiveRecord::Migration
  def change
    remove_index :links, column: :uid, name: :index_links_on_uid
    remove_index :trackings, column: :user_id, name: :index_trackings_on_user_id
    add_index :links, [:uid], name: :index_links_on_uid, unique: true, using: :btree
  end
end
