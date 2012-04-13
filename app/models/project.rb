class Project < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :phases, :dependent => :destroy
  has_many :cards, :through => :phases
  
  validates :name, :presence => true
end
