class CreateMainStreets < ActiveRecord::Migration[5.2]
  def change
    create_table :main_streets do |t|
      t.belongs_to :bus_line, null: false
      t.belongs_to :street, null: false

      # t.timestamps
    end

    add_index :main_streets, [:bus_line_id, :street_id], unique: true
  end
end
