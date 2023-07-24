class Task < ApplicationRecord
    belongs_to :project
    # has_one :user
    belongs_to :task_assigned_user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :created_by_user, class_name: 'User', foreign_key: 'created_by_id'
    enum status: { pending: 0, in_progress: 1, complete: 2 }
    validates :user_id, presence: true
    validates :project_id, presence: true
    validates :status, presence: true

    has_one_attached :ss
end
