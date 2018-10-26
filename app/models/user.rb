class User < ApplicationRecord
  has_and_belongs_to_many :cocktails
  attr_accessor :password
  before_save :encrypt_password

  validates :email, {presence: true, uniqueness: true}
  validates :name, {presence: true, uniqueness: true}
  validates :password, confirmation: true, if: :password_required?

  def password_required?
    self.new_record? || !self.password.blank?
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end

  def encrypt_password
    return if password.blank?
    if new_record?
      self.salt = SecureRandom.hex(16)
    end
    self.encrypted_password = User.encrypt self.password, self.salt
  end

  def self.authenticate(email, pass)
    user = User.where(email: email).first
    user && user.authenticated?(pass) ? user : nil
  end

  def authenticated?(pass)
    logger.info(encrypted_password)
    logger.info(pass)
    logger.info(User.encrypt(pass, self.salt))
    self.encrypted_password == User.encrypt(pass, self.salt)
  end
end
