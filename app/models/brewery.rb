class Brewery < ApplicationRecord
  include RatingAverage
  include Top
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042 }
  validate :year_must_be_current_year_or_older, on: :create

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def year_must_be_current_year_or_older
    return unless year > Time.now.year

    errors.add(:year, "must be current year or older")
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end

  def to_s
    name
  end
end
