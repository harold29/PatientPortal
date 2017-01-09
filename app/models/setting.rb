class Setting < ApplicationRecord
  belongs_to :user

  before_create :set_default_values

  private

  def set_default_values
    self.cal_sync = true
    self.send_notifications = true
  end
end
