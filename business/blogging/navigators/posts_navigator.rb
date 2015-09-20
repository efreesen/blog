require './business/blogging/manager'

module Blogging
  module Navigators
    class PostsNavigator
      def self.preview(listener)
        posts = Blogging::Manager.preview_posts
        has_more = Blogging::Manager.has_more_posts?

        listener.render_resources(posts, has_more)
      end

      def self.index(listener)
        posts = Blogging::Manager.posts

        listener.render_resources(posts)
      end

      def self.show(listener)
        post_slug = listener.params[:slug]
        post = Blogging::Manager.post(post_slug)

        if post
          listener.render_resource(post)
        else
          listener.resource_not_found
        end
      end
    end
  end
end
