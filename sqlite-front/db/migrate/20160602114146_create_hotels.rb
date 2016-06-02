class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :stars
      t.integer :accommodation

      t.timestamps null: false
    end
  end
end
