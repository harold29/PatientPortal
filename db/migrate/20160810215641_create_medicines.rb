class CreateMedicines < ActiveRecord::Migration[5.0]
  def change
    create_table :medicines do |t|
      t.date :start_date
      t.date :end_date
      t.string :frequency
      t.string :dose
      t.string :name
      t.string :way

      t.timestamps
    end
  end
end
