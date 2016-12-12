class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  before_create :set_default_values

  has_one :address
  has_one :patient
  has_one :doctor

  def self.from_omniauth(auth, user_id)
    logger.debug auth.to_s

    data = auth.info
    user = User.where(:gmail_email => data["email"]).first

    unless user
      user = User.find_by_id(user_id)
      user.gmail_email = data.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.auth_token = auth.credentials.token
      user.token_refresh = auth.credentials.refresh_token
      image = data.image
    end
    
    user.save
    user
  end

  def validate_token(v_token)
    if self.verification_token == v_token
      self.validated = true
      self.save
    else
      self.validated = false
    end
  end

  def set_disable
    self.disable = true
    self.save
  end

  def set_enable
    self.disable = false
    self.save
  end

  private

  def set_default_values
    self.role = 3
    self.disable = false
    self.validated = false
    self.verification_token = SecureRandom.urlsafe_base64(5)
  end
end
