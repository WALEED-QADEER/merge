module TasksHelper
    def project_options
      Project.accessible_by(current_ability).pluck(:name, :id)
    end
end