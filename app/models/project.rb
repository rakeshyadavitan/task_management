class Project < ApplicationRecord
	has_many :todos
	has_many :users, through: :todos 

  validates :name, presence: true
  validates :name, uniqueness: true, on: :create

	accepts_nested_attributes_for :todos, allow_destroy: true
end
