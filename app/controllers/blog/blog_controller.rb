require './business/blogging/navigators/posts_navigator'

class Blog::BlogController < ApplicationController
  layout 'blog'

  def index
    Blogging::Navigators::PostsNavigator.preview(self)
  end

  def about
  end

  def contact
  end

  def render_resources(posts, has_more)
    @posts = posts
    @has_more = has_more
  end
end
