class Blog::PostsController < ApplicationController
  layout 'blog'

  def index
    Blogging::Navigators::PostsNavigator.index(self)
  end

  def show
    Blogging::Navigators::PostsNavigator.show(self)
  end

  def feed
    Blogging::Navigators::PostsNavigator.feed(self)
  end

  def render_resources(posts)
    @posts = posts
  end

  def render_feed(posts)
    @posts = posts

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def render_resource(post)
    @post = post
  end
end
