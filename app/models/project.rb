class Project < ApplicationRecord
    # trigger_project_completion_worker, if: :saved_change_to_status?
    has_many :tasks
    has_many :memberships
    has_many :users, through: :memberships
    accepts_nested_attributes_for :memberships, reject_if: :all_blank, allow_destroy: true
    enum status: { pending: 0, in_progress: 1, complete: 2 }

    

#   private

#   def trigger_project_completion_worker
#     ProjectCompletionWorker.perform_async(id)
#   end
end
