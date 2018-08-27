class Company < ApplicationRecord
  has_many :users
  has_many :groups
  validates :name, presence: true, uniqueness: true
end
