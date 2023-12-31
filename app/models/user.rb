class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :projects, dependent: :destroy

  after_create :send_welcome_email

  def name
    [first_name, last_name].join(" ")
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
