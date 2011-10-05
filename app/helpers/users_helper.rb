module UsersHelper
  def get_number_of_posts(u)
    Post.get_user_post_count(u)
  end

  def get_number_of_votes_for(u)
    Post.get_num_votes_for(u)
  end

  def get_number_of_votes_by(u)
    Vote.get_num_votes_by(u)
  end
end
