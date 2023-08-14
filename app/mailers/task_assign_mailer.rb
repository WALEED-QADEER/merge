class TaskAssignMailer < ApplicationMailer
    default from: 'ws338558@gmail.com'

    def task_assigned_email(user)
        @user = user
        mail(to: @user.email, subject: 'New Task is assigned to you')
    end
    # def task_assigned_email
    #     @user = params[:user]
        
    #     mail(to: @user.task_assigned_user.email, subject: 'New Task is assigned to you')
    # end


    # def task_assigned_email(user, task)
    #     @user = user
    #     @task = task
        
    #     mail(to: @user.email, subject: 'New Task Assigned')
        
    # end

    # def welcome_email
    #     @user = params[:user]
    #     @url  = 'http://example.com/login'
    #     mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    #   end
end
