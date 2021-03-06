require './business/blogging/repositories/post_repository'

module Blogging
  class Manager
    def initialize(slug=nil)
      @slug = slug
    end

    def self.preview_posts(size=5)
      Repositories::PostRepository.latest(size)
    end

    def self.posts
      Repositories::PostRepository.all
    end

    def self.has_more_posts?(size=5)
      Repositories::PostRepository.has_more_posts?(size)
    end

    def self.post(slug)
      return unless slug

      Repositories::PostRepository.get(slug)
    end

    private
    attr_reader :slug
  end
end
