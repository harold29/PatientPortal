class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.references :user, foreign_key: true
      t.boolean :cal_sync
      t.string :calendar_id
      t.boolean :send_notifications

      t.timestamps
    end
  end
end
