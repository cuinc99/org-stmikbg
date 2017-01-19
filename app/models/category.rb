# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :title, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_created_at
    created_at.strftime("%-B %-d, %-Y")
  end
end
