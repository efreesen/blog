class Post < ActiveRecord::Base
  belongs_to :user

  scope :published, -> { where(published: true) }
  scope :with_slug, ->(slug) { find_by(slug: slug) }

  default_scope { order('published_at DESC') }

  def publish!
    return if published

    update_attributes(published: true, published_at: Time.now)
  end
end