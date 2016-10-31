class AddCountryToState < ActiveRecord::Migration[5.0]
  def change
    add_reference :states, :country, foreign_key: true
  end
end
