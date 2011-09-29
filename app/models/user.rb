class User < ActiveRecord::Base
  has_many :posts
  has_many :votes

  validates_presence_of :username

  validates_presence_of :email
  validates_presence_of :name

  validates_uniqueness_of :username
  validates_presence_of :password
  validate :password_check

  before_save :encrypt_password

  def encrypt_password
    self.password = Digest::SHA2.hexdigest(self.password)
  end

  def password_check
    if password.blank?
      errors.add(:password, "field can not be empty")
    end
    errors.add(:password, "can not be smaller than 6 or greater than 20 characters") if password.size < 6 or password.size > 20
  end

  def self.authenticate(user_name, password)
    user = self.find_by_username(user_name)
    if !user.nil?
      password = Digest::SHA2.hexdigest(password)
      if user.password.eql? password
        return user
      end
    end
    nil
  end

end
