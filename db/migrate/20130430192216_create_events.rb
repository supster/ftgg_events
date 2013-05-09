class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name
      t.text     :description
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string   :location
      t.string   :address
      t.float    :cost
      t.timestamps
    end
  end
end
