class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.references :user, index: true
      t.references :link, index: true, null: false
      t.inet :ip
    end

    add_foreign_key :trackings, :users, name: :trackings_user_id_fk, dependent: :delete
    add_foreign_key :trackings, :links, name: :trackings_link_id_fk, dependent: :delete
  end
end
