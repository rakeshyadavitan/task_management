class Todo < ApplicationRecord
	belongs_to :user
	belongs_to :project
	
	validates :title,:status, :user_id, :project_id, presence: true

  enum status: { created: 0, progress: 1, done: 2 }

end
