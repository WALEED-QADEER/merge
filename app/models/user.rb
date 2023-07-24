class User < ApplicationRecord

  has_many :memberships
  has_many :projects, through: :memberships
  # has_many :tasks
  has_many :assigned_task, class_name: 'Task', foreign_key: 'user_id'
  has_many :created_task, class_name: 'Task', foreign_key: 'created_by_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         enum role: { developer: 0, manager: 1, qa: 2 }
end
