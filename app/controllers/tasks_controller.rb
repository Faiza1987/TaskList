class TasksController < ApplicationController

  TASKS = [
    {
      task: "Hikefinder exercise Section 1", status: [:complete, :incomplete] 
    },
        {
      task: "Make lunch for the week", status: [:complete, :incomplete] 
    },
        {
      task: "Watch short video on MVC", status: [:complete, :incomplete] 
    },

  ]
  def index
    @tasks = Task.all;
  end
end
