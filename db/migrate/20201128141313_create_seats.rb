class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.integer :number, null: false
      t.string :seat_type, null: false
      t.integer :shop_id, null: false

      t.timestamps
    end
  end
end
