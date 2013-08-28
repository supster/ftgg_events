class CreateEvFavorites < ActiveRecord::Migration
  def change
    create_table :ev_favorites do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :ev_favorites, :user_id
    add_index :ev_favorites, :event_id
  end
end
