class CreateBusLineMainStreets < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_line_main_streets do |t|
      t.belongs_to :bus_line, null: false, index: true
      t.belongs_to :main_street, null: false,, index: true

      # t.timestamps
    end
  end
end
