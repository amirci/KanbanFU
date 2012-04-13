class Phase < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :project
  has_many :cards

  validates_presence_of :name, :description  
end
