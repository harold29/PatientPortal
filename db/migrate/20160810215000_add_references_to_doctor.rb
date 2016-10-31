class AddReferencesToDoctor < ActiveRecord::Migration[5.0]
  def change
    add_reference :doctors, :specialty, foreign_key: true
    add_reference :doctors, :service, foreign_key: true
  end
end
