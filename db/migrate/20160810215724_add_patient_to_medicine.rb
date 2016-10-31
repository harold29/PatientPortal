class AddPatientToMedicine < ActiveRecord::Migration[5.0]
  def change
    add_reference :medicines, :patient, foreign_key: true
  end
end
