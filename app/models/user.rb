class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence:true, format: { with: /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/ }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,32}\z/ }

  has_secure_password

  has_many :tasks
end
