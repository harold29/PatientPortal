class CreateClinics < ActiveRecord::Migration[5.0]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :mail
      t.string :phone1
      t.string :phone2
      t.string :phone3
      t.string :phone4
      t.string :fax

      t.timestamps
    end
  end
end
