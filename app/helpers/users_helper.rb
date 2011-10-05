module UsersHelper
  def get_number_of_posts(u)
    Post.get_user_post_count(u)
  end
end
