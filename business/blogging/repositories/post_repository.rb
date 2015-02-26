require 'active_support/inflector'

require './business/blogging/entities/post_entity'

module Blogging
  module Repositories
    class PostRepository
      def self.save(post)
        return nil unless post

        slug = post.slug ? post.slug : post.title.parameterize

        resource = Post.published.with_slug(slug).first_or_initialize

        resource.update_attributes(post.attributes)

        serialize(resource)
      end

      def self.all
        resources = Post.published

        serialize(resources)
      end

      def self.get(slug)
        resource = Post.find_by(slug: slug)

        serialize(resource)
      end

      def self.latest(size)
        collection = Post.published.limit(size)

        return collection if collection.empty?

        serialize(collection)
      end

      def self.has_more_posts?(size)
        Post.published.count > size
      end

      private
      def self.serialize(object)
        return unless object

        if object.respond_to?(:size)
          object.map do |obj|
            serialize(obj)
          end
        else
          attributes = object.attributes
          attributes[:user_name] = object.user.name
          attributes[:user_page] = object.user.page

          Blogging::Entities::PostEntity.new(attributes)
        end
      end
    end
  end
end

