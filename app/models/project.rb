class Project < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :cards, :dependent => :destroy
  has_many :phases, :dependent => :destroy
  
  validates :name, :presence => true
end
