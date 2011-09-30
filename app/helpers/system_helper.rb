module SystemHelper
  def get_user_name_from_user_id(u)
    @uname = User.find_by_id(u)
    if @uname.nil? or @uname.eql?("")
      "Anonymous"
    else
      @uname.username
    end
  end
end
