# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  banner       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string
#  author_id    :integer
#  published    :boolean          default("f")
#  published_at :datetime
#

class Post < ApplicationRecord
  is_impressionable :counter_cache => true, column_name: :view, :unique => :all

  belongs_to :author
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, :content, :post_categories, presence: true

  scope :most_recent, -> { order(published_at: :desc)   }
  scope :published, -> { where(published: true)   }

  has_attached_file :image, styles: { medium: "700x350>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  acts_as_taggable_on :tags

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

  def display_category
    categories.map { |category| category.title }.join(", ")
  end

  def display_tag
    tags.map { |tag| tag.name.titleize }.join(", ")
  end

  def self.search(search)
    if search
      where("title or content LIKE ?","%#{search}%")
    else
      published
    end
  end
end
