class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :blood_type
      t.string :iee
      t.string :married
      t.string :studies
      t.string :case_file
      t.string :religion

      t.timestamps
    end
  end
end
