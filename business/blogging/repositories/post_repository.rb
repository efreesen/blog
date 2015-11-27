require 'active_support/inflector'

require './business/blogging/entities/post_entity'

module Blogging
  module Repositories
    class PostRepository
      def self.save(post)
        return false unless post

        post.slug ||= post.title.parameterize

        resource = Post.with_slug(post.slug).first_or_initialize

        resource.update_attributes(post.model_attributes)

        serialize(resource)
      end

      def self.publish!(slug)
        return false unless slug

        post = Post.with_slug(slug)

        post.publish! if post
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
      attr_accessor :post

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

