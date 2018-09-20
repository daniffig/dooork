class BusLineMainStreet < ApplicationRecord
  belongs_to :bus_line
  belongs_to :main_street

  validates :main_street, uniqueness: { scope: :bus_line }  
end
