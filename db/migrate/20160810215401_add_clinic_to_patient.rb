class AddClinicToPatient < ActiveRecord::Migration[5.0]
  def change
    add_reference :patients, :clinic, foreign_key: true
  end
end
