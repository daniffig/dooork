class MainStreet < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :city, presence: true
  
end
