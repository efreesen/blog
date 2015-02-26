require './business/blogging/manager'

module Blogging
  module Navigators
    class PostsNavigator
      def self.index(listener)
        posts = Blogging::Manager.posts
        has_more = Blogging::Manager.has_more_posts?

        listener.render_resources(posts, has_more)
      end

      def self.show(listener)
        post_slug = listener.params[:slug]
        post = Blogging::Manager.post(post_slug)

        listener.render_resource(post)
      end
    end
  end
end
