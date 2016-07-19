class Actor < ApplicationRecord
  has_many :castings
  has_many :movies, through: :castings

  validates :firstname, presence: true
  validates :lastname, presence: true
end
