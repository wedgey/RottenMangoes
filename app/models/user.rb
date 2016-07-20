class User < ApplicationRecord
  has_many :reviews
  
  has_secure_password

  validates :email, presence: true
  validates :password, length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end

  def admin?
    admin
  end
end
