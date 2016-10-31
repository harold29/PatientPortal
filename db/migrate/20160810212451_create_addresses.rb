class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :location
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
