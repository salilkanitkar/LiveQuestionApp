module SystemHelper
  def get_user_name_from_user_id(u)
    @uname = User.find_by_id(u)
    if @uname.nil? or @uname.eql?("")
      "Anonymous"
    else
      @uname.username
    end
  end

  def delete_my_votes(pid)
    myvotes = Vote.find_all_by_post_id(pid)
    if myvotes.nil? == false
      myvotes.each do |myvote|
        myvote.destroy
      end
    end
  end

  def get_number_of_replies(p)
    Post.get_count_of_replies(p)
  end

end
