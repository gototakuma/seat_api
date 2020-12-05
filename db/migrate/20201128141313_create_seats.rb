class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.integer :number, null: false, comment: '座席番号'
      t.string :seat_type, null: false, comment: '座席タイプ'
      t.boolean :is_use, default: false, comment: '使用可・使用中'
      t.integer :shop_id, null: false

      t.timestamps
    end
  end
end
