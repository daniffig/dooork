class BusLine < ApplicationRecord
  has_many :bus_line_main_streets
  has_many :main_streets, through: :bus_line_main_streets
  
  validates :code, presence: true, uniqueness: true

end
