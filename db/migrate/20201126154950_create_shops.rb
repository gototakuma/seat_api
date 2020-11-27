class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name, null: false, comment: '店舗名'
      t.string :login_id, null: false, comment: 'ログインID'
      t.string :password_digest, null: false, comment: 'パスワード'
      t.string :address, null: false, comment: '住所'

      t.timestamps
    end
  end
end
