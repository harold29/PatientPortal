class AddColumnsToSetting < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :workday_mon, :boolean
    add_column :settings, :workday_tue, :boolean
    add_column :settings, :workday_wed, :boolean
    add_column :settings, :workday_thu, :boolean
    add_column :settings, :workday_fri, :boolean
    add_column :settings, :workday_sat, :boolean
    add_column :settings, :workday_sun, :boolean
    add_column :settings, :appointment_block, :integer
    add_column :settings, :initial_work_hour, :time
    add_column :settings, :final_work_hour, :time
  end
end
