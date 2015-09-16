class RegisteredApplication < ActiveRecord::Base

  validates :name, :url,
              presence: true,
              uniqueness: true

  belongs_to :user
end
