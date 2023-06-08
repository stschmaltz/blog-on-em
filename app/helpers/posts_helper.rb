module PostsHelper
  def published(post)
    if post.published_at.present?
      post.published_at.strftime('%-b %-d, %Y')
    else
      'Not published yet'
    end
  end
end
