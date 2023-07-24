class ProjectCompletionWorker
  include Sidekiq::Worker

  def perform(project_id)
    # Find the project with the given ID
    project = Project.find_by(id: project_id)

    if project && project.status == 'complete'
      # If the project is complete, update associated tasks after a one-minute delay
      tasks = project.tasks.where.not(status: 'complete')
      tasks.update_all(status: 'complete') unless tasks.empty?
    end
  end
end
