class ProjectsController < ApplicationController
  load_and_authorize_resource
    def index
      
        @projects = Project.accessible_by(current_ability)
        # Blog.accessible_by(current_ability, :update)
        # @projects = Project.all
        respond_to do |format|
          format.html { render :index }  # Render the HTML view
          format.json { render json: @projects }  # Render JSON for API requests
        end
          if params[:search_by_projectname] && params[:search_by_projectname] != ""
          @projects = Project.where("name LIKE ?","#{params[:search_by_projectname]}%").accessible_by(current_ability)
         
        end
      end
      def show
          @project = Project.find(params[:id])
          # @users = @project.users
          respond_to do |format|
            format.html { render :show }  # Render the HTML view
            format.json { render json: @project }  # Render JSON for API requests
          end
      end
     
      def new
          @project = Project.new
          @project.memberships.build
            
         
        end
      
        def create
          @project = Project.new(project_params)
         
          if @project.save
            redirect_to @project
          else
            render :new, status: :unprocessable_entity
          end
        end
        def edit
          @project = Project.find(params[:id])
          @project.memberships.build
         
          redirect_back_or_to @project, alert: exception.message
          
        end
      
        def update
          
          @project = Project.find(params[:id])
          
      
          if @project.update(project_params)
            if @project.status == 'complete'
              # Enqueue the ProjectCompletionWorker to update associated tasks after a delay
              ProjectCompletionWorker.perform_in(1.minute, @project.id)
            end
            redirect_to @project
          else
            render :edit, status: :unprocessable_entity
          end
        end
        def destroy
          @project = Project.find(params[:id])
          @project.destroy
      
          redirect_to project_path, status: :see_other
        end
  
       
        private
        def project_params
          params.require(:project).permit(:name, :creator, :status, :date, memberships_attributes: [:id, :user_id, :_destroy])
        end
    end
