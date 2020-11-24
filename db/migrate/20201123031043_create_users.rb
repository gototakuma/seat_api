class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, comment: '名前'
      t.string :login_id, null: false, comment: 'ログインID'
      t.string :password_digest, null: false, comment: 'パスワード'

      t.timestamps
    end
  end
end
