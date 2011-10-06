class Post < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'
  has_many :post
  has_many :votes

  validates_presence_of :question

  def self.get_top_posts
    all(:order => "numofvotes DESC, created_at DESC", :limit => 50, :conditions => {:parent => nil})
  end

  def self.get_replies(p)
    all(:order => "created_at ASC", :conditions => {:parent => p})
  end

  def self.get_count_of_replies(p)
    count(:conditions => {:parent => p})
  end

  def self.get_user_post_count(u)
    count(:conditions => {:user_id => u})
  end

  def self.get_num_votes_for(u)
    sum(:numofvotes, :conditions => {:user_id => u})
  end

  def self.search(key)
    all(:order => "numofvotes DESC, created_at DESC", :conditions => ["lower(#{:question}) like ?", '%' + key.downcase + '%'])
  end

end
