class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :user, index: true, null: false
      t.string :uid, null: false
      t.string :url, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index :links, :uid
    add_foreign_key :links, :users, name: :links_user_id_fk, dependent: :delete
  end
end
