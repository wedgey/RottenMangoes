class Movie < ApplicationRecord
  scope :title_search, ->(title) { where("title like ?", "%#{title}%") }
  scope :director_search, ->(director) { where("director like ?", "%#{director}%") }
  scope :under_90_search, -> { where("runtime_in_minutes < 90") }
  scope :between_90_120_search, -> { where("runtime_in_minutes BETWEEN 90 AND 120") }
  scope :over_120_search, -> { where("runtime_in_minutes > 120") }
  scope :better_search, -> (title, director) { where("title like ? OR director like ?", "%#{title}%", "%#{director}%") }

  mount_uploader :poster_image_url, ImageUploader
  has_many :reviews
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
