class CreateRelatives < ActiveRecord::Migration[5.0]
  def change
    create_table :relatives do |t|
      t.string :name
      t.string :kinship
      t.string :phone1
      t.string :phone2
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
