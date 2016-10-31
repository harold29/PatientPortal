class AddDoctorToMedicine < ActiveRecord::Migration[5.0]
  def change
    add_reference :medicines, :doctor, foreign_key: true
  end
end
