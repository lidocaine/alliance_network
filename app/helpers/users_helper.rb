module UsersHelper
  def avatar_for(user, options = { :size => 150 })
    gravatar_image_tag(user.email.downcase, :alt => user.username,
                                            :class => 'avatar',
                                            :gravatar => options)
  end
end
