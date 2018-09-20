class MainStreet < ApplicationRecord
  belongs_to :bus_line
  belongs_to :street
  
end
