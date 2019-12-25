class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]
  
  before_destroy { classrooms.clear }

  validates :fullname, :username, presence: true

  has_and_belongs_to_many :classrooms

  attr_writer :login

  def eligable_enroll(room)
    classrooms.where(id: room.id).blank?
  end

  def login
    @login || self.email || self.username
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
