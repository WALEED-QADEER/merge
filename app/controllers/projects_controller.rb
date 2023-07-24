class ProjectsController < ApplicationController
  load_and_authorize_resource
    def index
      
        @projects = Project.accessible_by(current_ability)
        # Blog.accessible_by(current_ability, :update)
        
          if params[:search_by_projectname] && params[:search_by_projectname] != ""
          @projects = Project.where("name LIKE ?","#{params[:search_by_projectname]}%").accessible_by(current_ability)
         
        end
      end
      def show
          @project = Project.find(params[:id])
          @users = @project.users
                   
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
