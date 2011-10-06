require 'digest'

class User < ActiveRecord::Base
  has_many :posts
  has_many :votes

  validates_presence_of :username

  validates_presence_of :email
  validates_presence_of :name

  validates_uniqueness_of :username
  validates_presence_of :password
  validate :password_check

  validates_format_of :email,:with => /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/

  before_save :encrypt_password

  def encrypt_password
    if new_record?
      self.password = Digest::SHA2.hexdigest(self.password)
    end
    if self.isadmin.nil?
      self.isadmin=0
    end
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

  def self.search(key)
    all(:conditions => ["lower(#{:username}) like ?", '%' + key.downcase + '%'])
  end

private
  def password_check
      if self.password.blank?
        errors.add(:password, "field can not be empty")
      end
      errors.add(:password, "can not be smaller than 6 or greater than 20 characters:"+self.password+":") if self.password.length < 6 or self.password.length > 20
  end
end
