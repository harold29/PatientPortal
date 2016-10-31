class AddUserToDoctor < ActiveRecord::Migration[5.0]
  def change
    add_reference :doctors, :user, foreign_key: true
  end
end
