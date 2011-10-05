class Post < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'
  has_many :post
  has_many :votes

  validates_presence_of :question

  def self.get_top_posts
    all(:order => "numOfVotes DESC, created_at DESC", :limit => 50, :conditions => {:parent => nil})
  end

  def self.get_replies(p)
    all(:conditions => {:parent => p})
  end

  def self.get_count_of_replies(p)
    count(:conditions => {:parent => p})
  end

  def self.get_user_post_count(u)
    count(:conditions => {:user_id => u})
  end

  def self.search(key)
    all(:order => "numOfVotes DESC, created_at DESC", :conditions => ["#{:question} like ?", '%' + key + '%'])
  end

end
