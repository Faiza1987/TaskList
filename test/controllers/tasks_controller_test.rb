require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create task: "sample task", descriptions: "this is an example for a test",
                completion_date: "date"
  }

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do
      # skip
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      # skip

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      # skip

      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          task: "new task",
          descriptions: "new task description",
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path(), params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(task: task_hash[:task][:task])
      expect(new_task.descriptions).must_equal task_hash[:task][:descriptions]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # skip
      update_task = Task.create(task: "Hiking")
      get edit_task_path(update_task)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
      
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      # skip
      
      # updated information
      task_hash = {
        task: {
          task: "Cleaning",
          descriptions: "My apartment",
          completion_date: "tomorrow"
        }
      }
                      
      task_to_be_updated = Task.create(task: "Clean", descriptions: "entire apartment", completion_date: "today")
      patch task_path(task_to_be_updated.id, params: task_hash)
      
      # pulls task back from database
      task_to_be_updated.reload


      expect(task_to_be_updated.created_at).wont_equal task_to_be_updated.updated_at

      puts "VVVVV TASK VVVVVVVVV"
      puts task_hash[:task][:task]
      expect(task_to_be_updated.task).must_equal task_hash[:task][:task]

      puts "VVVV DESCRIPTION VVVVVVVVVV"
      puts task_hash[:task][:descriptions]
      expect(task_to_be_updated.descriptions).must_equal task_hash[:task][:descriptions]

      puts "VVVVVV COMPLETION_DATE VVVVVVVV"
      puts task_hash[:task][:completion_date]
      expect(task_to_be_updated.completion_date).must_equal task_hash[:task][:completion_date]
      
    end

    it "will redirect to the root page if given an invalid id" do
      # skip
            task_hash = {
        task: {
          task: "Cleaning",
          descriptions: "My apartment",
          completion_date: "tomorrow"
        }
      }


      invalid_id = 999
      patch task_path(invalid_id, params: task_hash)
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end