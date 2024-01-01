class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :projects, dependent: :destroy
  has_many :notes, dependent: :destroy

  before_save :ensure_authentication_token
  after_create :send_welcome_email

  def name
    [first_name, last_name].join(" ")
  end

  private

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
