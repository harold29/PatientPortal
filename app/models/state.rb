class State < ApplicationRecord
  belongs_to :country
  has_many :municipalities, dependent: :destroy
end
