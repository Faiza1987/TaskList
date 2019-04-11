class TasksController < ApplicationController

  # TASKS = [
  #   {
  #     task: "Hikefinder exercise Section 1", status: [:complete, :incomplete] 
  #   },
  #       {
  #     task: "Make lunch for the week", status: [:complete, :incomplete] 
  #   },
  #       {
  #     task: "Watch short video on MVC", status: [:complete, :incomplete] 
  #   },

  # ]
  def index
    @tasks = Task.all;
  end

  def show 
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def new 
    @task = Task.new
    @task.task = "I have to..."
    @task.completion_date = "incomplete"
  end

    def create 
    new_task = Task.new(
      task: params["task"]["task"],
      descriptions: params["task"]["descriptions"], 
      completion_date: params["task"]["completion_date"]
    )
        
    is_successful = new_task.save

    if is_successful
      redirect_to task_path(new_task.id)
    else
      head :found
    end

    # Book.create will also work
  end

  def edit 
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
  end

  def update 
    edit_task_id = params[:id].to_i
    edited_task = Task.find(edit_task_id)
    
    # follows browser structure
    new_completion_date = params["task"]["completed"]
    new_description = params["task"]["description"]
    new_name = params["task"]["name"]

    # based on schema
    edited_task.task = new_name
    edited_task.descriptions = new_description
    edited_task.completion_date = new_completion_date
    
    is_successful = edited_task.save
    # raise

    if is_successful
      redirect_to task_path(edit_task_id)
    else
      redirect_to tasks_path
    end
  end
end
