class CherubimUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable
  belongs_to :role
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
   uniqueness: true
   validates_presence_of :country,:first_name,:last_name,:Nic,:Dob
  validates_presence_of :first_name, :last_name, :Dob, :Nic
end
