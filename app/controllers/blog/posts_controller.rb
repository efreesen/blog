class Blog::PostsController < ApplicationController
  layout 'blog'

  def index
    raise 'OK'
    Blogging::Navigators::PostsNavigator.index(self)
  end

  def show
    Blogging::Navigators::PostsNavigator.show(self)
  end

  def render_resources(posts)
    @posts = posts
  end

  def render_resource(post)
    @post = post
  end
end
