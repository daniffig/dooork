class Street < ApplicationRecord  
  has_many :main_streets
  has_many :bus_lines, through: :main_streets
  
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :city, presence: true
  
end
