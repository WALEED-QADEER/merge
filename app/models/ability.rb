class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
      if user.manager?
        can :manage, Task
        # can :manage, @task, user_id: user.id
        can :manage, Project
      elsif user.qa?
        can :manage, Task, created_by_id: user.id
        can :read, Project
      elsif user.developer?
        can :read, Task, user_id: user.id
        cannot :manage, Project    
      end
    #   return unless user.admin?  # additional permissions for administrators
    #   can :manage, :all
    #   return unless user.manager?  # additional permissions for logged in users (they can read their own posts)
    # can :manage, Task, user: user
    # can :manage, Project, user: user

   
   
      
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
