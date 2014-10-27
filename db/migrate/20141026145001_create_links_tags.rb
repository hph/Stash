class CreateLinksTags < ActiveRecord::Migration
  def change
    create_table :links_tags, id: false do |t|
      t.references :tag, null: false
      t.references :link, null: false
    end

    add_index :links_tags, [:tag_id, :link_id], unique: true
    add_foreign_key :links_tags, :tags, name: :links_tags_tag_id_fk, dependent: :delete
    add_foreign_key :links_tags, :links, name: :links_tags_link_id_fk, dependent: :delete
  end
end
