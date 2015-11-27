require 'entity_rb'

module Blogging
  module Entities
    class PostEntity < Entity::Base
      field :user_name
      field :user_page
      field :user_id
      field :slug
      field :title
      field :subtitle
      field :content
      field :published
      field :created_at
      field :published_at
      field :updated_at
      field :errors

      def model_attributes
        attributes.dup.tap do |attrs|
          [:user_name, :user_page, :errors].each { |attr| attrs.delete(attr) }
        end
      end
    end
  end
end
