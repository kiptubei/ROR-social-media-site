module PostsHelper
  def get_timeline_posts(timeline_posts)
    if @timeline_posts.empty?
      '<p> You have no posts </p>'.html_safe
    else
      render @timeline_posts
    end
  end
end