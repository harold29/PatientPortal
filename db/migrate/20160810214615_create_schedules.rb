class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.date :day
      t.time :hour
      t.boolean :available

      t.timestamps
    end
  end
end
