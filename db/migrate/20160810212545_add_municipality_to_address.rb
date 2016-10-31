class AddMunicipalityToAddress < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :municipality, foreign_key: true
  end
end
