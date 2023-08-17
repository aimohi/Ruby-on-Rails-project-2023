class Membership < ApplicationRecord
  belongs_to :beer_club
  belongs_to :user

  def to_s
    "#{user.username} #{beer_club.name}"
  end
end
