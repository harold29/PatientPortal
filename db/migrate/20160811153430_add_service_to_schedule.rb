class AddServiceToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_reference :schedules, :service, foreign_key: true
  end
end
