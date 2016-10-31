class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :professional_document

      t.timestamps
    end
  end
end
