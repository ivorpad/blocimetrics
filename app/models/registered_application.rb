class RegisteredApplication < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  validates :url,
            format: URI::regexp(%w(http https)),
            presence: true,
            uniqueness: true

  belongs_to :user
  has_many :events
end
