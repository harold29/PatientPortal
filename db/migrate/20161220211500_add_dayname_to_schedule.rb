class AddDaynameToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :dayname, :string
  end
end
