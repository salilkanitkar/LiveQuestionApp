class Post < ActiveRecord::Base
  belongs_to :user, :foreign_key => 'user_id'
  has_many :post
  has_many :votes

  validates_presence_of :question

  def self.get_top_posts
    all(:order => "numOfVotes DESC", :limit => 25, :conditions => {:parent => nil} )
  end

  def self.get_replies(p)
    all(:conditions => {:parent => p})
  end
end
