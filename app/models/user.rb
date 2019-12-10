class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :contacts
  has_many :sents, class_name: "Message", foreign_key: "sender_id"
  has_many :receiveds, class_name: "Message", foreign_key: "receiver_id"

  validates :name, presence: true

end
