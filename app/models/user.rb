class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, format: { with: /@/ },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_create :generate_slug
  before_save { self.email = email.downcase }
  before_save :generate_remember_token

  has_many :microposts, -> { order "created_at DESC" }, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_relationships

  def to_param
    slug
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  private
  def generate_slug
    loop do
      token = SecureRandom.urlsafe_base64(4)
      break self.slug = token unless User.exists?(:slug => token)
    end
  end

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
