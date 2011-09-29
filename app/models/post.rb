class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post

  validates_presence_of :question
end
