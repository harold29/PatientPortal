class CreateSpecialties < ActiveRecord::Migration[5.0]
  def change
    create_table :specialties do |t|
      t.string :name
      t.boolean :parent

      t.timestamps
    end
  end
end
