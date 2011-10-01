module PostsHelper

  def delete_my_votes(pid)
    myvotes = Vote.find_all_by_post_id(pid)
    if myvotes.nil? == false
      myvotes.each do |myvote|
        myvote.destroy
      end
    end
  end

end
