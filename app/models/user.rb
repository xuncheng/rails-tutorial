class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, format: { with: /@/ },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_create :generate_slug

  def to_param
    slug
  end

  private
  def generate_slug
    loop do
      token = SecureRandom.urlsafe_base64(4)
      break self.slug = token unless User.exists?(:slug => token)
    end
  end
end
