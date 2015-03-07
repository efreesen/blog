require './business/blogging/navigators/posts_navigator'

class Blog::BlogController < ApplicationController
  layout 'blog'

  caches_action :index, expires_in: 2.hour
  caches_action :about, expires_in: 24.hour

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
