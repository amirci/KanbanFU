class Phase < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :project

  validates_presence_of :name, :description  
end
