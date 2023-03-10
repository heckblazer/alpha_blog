class User < ApplicationRecord
  before_save do
    self.email = email.downcase
    self.username = username.downcase
  end
  has_many :articles, dependent: :destroy
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
                       length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                    length: { maximum: 200 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end