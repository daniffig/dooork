class MainStreet < ApplicationRecord
  has_many :bus_line_main_streets
  has_many :bus_lines, through: :bus_line_main_streets
  
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :city, presence: true
  
end
