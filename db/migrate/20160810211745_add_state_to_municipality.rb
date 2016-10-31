class AddStateToMunicipality < ActiveRecord::Migration[5.0]
  def change
    add_reference :municipalities, :state, foreign_key: true
  end
end
