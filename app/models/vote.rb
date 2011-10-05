class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def self.get_num_votes_by(u)
    count(:conditions => {:user_id => u})
  end
end
