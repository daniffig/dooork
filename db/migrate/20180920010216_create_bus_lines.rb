class CreateBusLines < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_lines do |t|
      t.string :code

      # t.timestamps
    end
  end
end
