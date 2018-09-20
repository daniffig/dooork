class CreateStreets < ActiveRecord::Migration[5.2]
  def change
    create_table :streets do |t|
      t.string :code
      t.string :name
      t.string :city

      # t.timestamps
    end
  end
end
