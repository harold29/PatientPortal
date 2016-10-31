class AddClinicToService < ActiveRecord::Migration[5.0]
  def change
    add_reference :services, :clinic, foreign_key: true
  end
end
