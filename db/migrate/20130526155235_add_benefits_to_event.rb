class AddBenefitsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :benefits, :string
  end
end
