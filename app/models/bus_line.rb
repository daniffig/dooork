class BusLine < ApplicationRecord
  has_many :main_streets
  has_many :streets, through: :main_streets
  
  validates :code, presence: true, uniqueness: true

end
