class TasksController < ApplicationController
  load_and_authorize_resource
  include TasksHelper
    def index
        
        @tasks = Task.accessible_by(current_ability)
        if params[:search_by_taskname] && params[:search_by_taskname] != ""
          @tasks = Task.where("task_type LIKE ?","#{params[:search_by_taskname]}%").accessible_by(current_ability)
        end
        # elsif current_user.manager?
        #     @tasks = Task.where("created_by_id": current_user.id)
        #     if params[:search_by_taskname] && params[:search_by_taskname] != ""
        #       @tasks = Task.where("task_type LIKE ?","#{params[:search_by_taskname]}%").and(Task.where("created_by_id": current_user.id))
             
        #     end
        # elsif current_user.coder?
        #   @tasks = Task.where("user_id": current_user.id)
        #   if params[:search_by_taskname] && params[:search_by_taskname] != ""
        #     @tasks = Task.where("task_type LIKE ?","#{params[:search_by_taskname]}%").and(Task.where("user_id": current_user.id))
           
        #   end
        # end
          
      end
      def show
          @task = Task.find(params[:id])
          
      end
      def search
        @projects = Project.where('name LIKE ?', "%#{params[:q]}%").accessible_by(current_ability)
        
    respond_to do |format|
      format.json { render json: @projects }
    end
      end
     
      def search_projects
        search_term = params[:search_term]
        @projects = Project.where('name ILIKE ?', "%#{search_term}%") # Adjust the column name based on your Project model
    
        respond_to do |format|
          format.json { render json: @projects, only: [:id, :name] } 
        end
      end
     
      def new
          @task = Task.new
            
         
        end
      
        def create
          @task = Task.new(task_params)
          
         
          if @task.save
            redirect_to @task
          else
            render :new, status: :unprocessable_entity
          end
          
        end
        def edit
          
          @task = Task.find(params[:id])
         
  
          
        end
      
        def update
          
          @task = Task.find(params[:id])
          
      
          if @task.update(task_params)
            redirect_to @task
          else
            render :edit, status: :unprocessable_entity
          end
        end
        def destroy
          @task = Task.find(params[:id])
          @task.destroy
      
          redirect_to task_path, status: :see_other
        end
  
       
        private
        def task_params
          params.require(:task).permit(:task_type, :user_id, :project_id, :description, :completion_date, :status, :created_by_id, :ss)
        end
        
end
