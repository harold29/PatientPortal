class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.boolean :accepted
      t.date :appointment_date
      t.boolean :gcal_doc
      t.boolean :gcal_patient

      t.timestamps
    end
  end
end
