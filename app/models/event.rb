class Event < ApplicationRecord
  is_impressionable :counter_cache => true, column_name: :view, :unique => :all
  belongs_to :author

  validates :title, :description, :status, :quota, :start, :end, :location, :link_register, presence: true

  scope :most_recent, -> { order(published_at: :desc)   }
  scope :published, -> { where(published: true)   }

  has_attached_file :image, styles: { medium: "700x350>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end

  def publish
    update(published: true, published_at: Time.now)
  end

  def unpublish
    update(published: false, published_at: nil)
  end

  def display_day_published
    if published_at.present?
      published_at.strftime('%-b %-d, %-Y')
    else
      "Not Published yet"
    end
  end

  def display_date
    start.strftime("%a, %e %b %y at %I:%M")
  end

  def self.search(search)
    if search
      where("title or description or status or location LIKE ?","%#{search}%")
    else
      published
    end
  end
end
