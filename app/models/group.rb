class Group < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :users
end
