class Post < ActiveRecord::Base
  belongs_to :user

  scope :published, -> { where(published: true) }
  scope :with_slug, ->(slug) { where(slug: slug) }

  default_scope { order('published_at') }
end