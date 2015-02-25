class Blog::PostsController < ApplicationController
  layout 'blog'

  def index
    Blogging::Navigators::PostsNavigator.index(self)
  end

  def show
    Blogging::Navigators::PostsNavigator.show(self)
  end
end
