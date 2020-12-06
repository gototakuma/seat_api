class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.text :description, null: false, comment: '本文'
      t.boolean :is_sent, default: false, comment: '送信'
      t.integer :shop_id, null: false

      t.timestamps
    end
  end
end
