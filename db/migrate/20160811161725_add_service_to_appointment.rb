class AddServiceToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_reference :appointments, :service, foreign_key: true
  end
end
