class AddStateToAddress < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :state, foreign_key: true
  end
end
