# == Schema Information
#
# Table name: authors
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :pages
  has_many :events

  has_attached_file :avatar, styles: { medium: "700x350>", thumb: "38x38>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || new_record? || slug.nil? || slug.blank?
  end

  def member_since
    if created_at.present?
      created_at.strftime('%-b %-d, %-Y')
    else
      "Not Published yet"
    end
  end

  enum jenis: {
      "Badan Eksekutif Mahasiswa" => "Badan Eksekutif Mahasiswa",
      "Unit Kegiatan Mahasiswa" => "Unit Kegiatan Mahasiswa",
      "Study Club" => "Study Club"
  }

  scope :bem, -> { where(jenis: "Badan Eksekutif Mahasiswa") }
  scope :ukm, -> { where(jenis: "Unit Kegiatan Mahasiswa") }
  scope :sc, -> { where(jenis: "Study Club") }
end
