class CreateEventBrites < ActiveRecord::Migration
  def change
    create_table :event_brites do |t|
      t.string :eb_id
      t.string :name
      t.text :description
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :url
      t.string :location
      t.string :address
      t.float :cost
      t.boolean :archieve
      t.boolean :display

      t.timestamps
    end
  end
end
