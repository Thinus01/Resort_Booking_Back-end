class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :resorts, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
end
