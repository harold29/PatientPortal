class Appointment < ApplicationRecord
  before_create :set_default_values

  belongs_to :patient

  def set_accepted
    self.accepted = true
    self.save
  end

  private 

  def set_default_values
    self.accepted = false
  end
end
