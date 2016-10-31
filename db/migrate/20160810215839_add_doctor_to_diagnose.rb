class AddDoctorToDiagnose < ActiveRecord::Migration[5.0]
  def change
    add_reference :diagnoses, :doctor, foreign_key: true
  end
end
