class Card < ActiveRecord::Base
  validates :title, :presence => true
  belongs_to :phase
end
