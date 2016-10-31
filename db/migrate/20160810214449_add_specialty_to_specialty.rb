class AddSpecialtyToSpecialty < ActiveRecord::Migration[5.0]
  def change
    add_reference :specialties, :specialty, foreign_key: true
  end
end
