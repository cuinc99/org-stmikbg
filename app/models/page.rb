class Page < ApplicationRecord
  validates :title, :content, presence: true

  belongs_to :author

  scope :most_recent, -> { order(published_at: :desc) }
  scope :published, -> { where(published: true) }

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

  def display_date_published
    if published_at.present?
      published_at.strftime("%-d %-b, %-Y")
    else
      "Not Published yet"
    end
  end
end
