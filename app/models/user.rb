class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :authentication_keys => [:login]
  has_many :contacts
  has_many :sents, class_name: "Message", foreign_key: "sender_id"
  has_many :receiveds, class_name: "Message", foreign_key: "receiver_id"

  has_one_attached :photo
 
  validates :name, presence: true
  validates :cell_phone, presence: true #, unique: true
  validates_uniqueness_of :cell_phone

  def login=(login)
    @login = login
  end

  def login
    @login || self.cell_phone
  end

  # reescrita do metodo de login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(cell_phone) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:cell_phone)
      where(conditions.to_hash).first
    end
  end

end
