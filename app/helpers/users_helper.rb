module UsersHelper
  def display_friend_invite_button(user)
    unless current_user == user || current_user.check_friendship_status(user)
      link_to 'Add as friend', "/users/#{user.id}/add_friend", class: 'profile-link', method: :put
    end
  end
end
