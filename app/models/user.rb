class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, format: { with: /@/ },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
end
