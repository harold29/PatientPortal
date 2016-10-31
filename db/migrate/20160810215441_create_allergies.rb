class CreateAllergies < ActiveRecord::Migration[5.0]
  def change
    create_table :allergies do |t|
      t.date :init_date
      t.string :name
      t.text :obs

      t.timestamps
    end
  end
end
