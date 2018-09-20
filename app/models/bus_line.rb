class BusLine < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  
end
