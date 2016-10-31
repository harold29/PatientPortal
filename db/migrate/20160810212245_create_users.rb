class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :gender
      t.integer :role
      t.integer :age
      t.date :birthday
      t.string :type
      t.string :access_token
      t.string :id_token
      t.boolean :disable
      t.string :verification_token
      t.boolean :validated

      t.timestamps
    end
  end
end
