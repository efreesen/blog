class PostsPresenter
  def self.preview_partial(posts)
    posts.empty? ? '/blog/posts/empty' : '/blog/posts/preview_posts'
  end
end