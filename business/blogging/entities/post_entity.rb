require 'entity_rb'

module Blogging
  module Entities
    class PostEntity < Entity::Base
      field :user_name
      field :slug
      field :title
      field :subtitle
      field :content
      field :published
      field :created_at
      field :published_at
      field :updated_at
      field :errors
    end
  end
end
