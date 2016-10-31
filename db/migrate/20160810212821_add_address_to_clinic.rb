class AddAddressToClinic < ActiveRecord::Migration[5.0]
  def change
    add_reference :clinics, :address, foreign_key: true
  end
end
