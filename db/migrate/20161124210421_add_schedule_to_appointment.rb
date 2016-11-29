class AddScheduleToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_reference :appointments, :schedule, foreign_key: true
  end
end
