class CreateUtilizationTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :utilization_times do |t|
      t.datetime :started_at, comment: '利用開始時間'
      t.datetime :finished_at, comment: '利用終了時間'
      t.integer :user_id
      t.integer :seat_id

      t.timestamps
    end
  end
end
