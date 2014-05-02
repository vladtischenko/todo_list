class TodoList.Routers.Tasks extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    tasks = new TodoList.Collections.Tasks
    new TodoList.Views.TasksIndex collection: tasks
    tasks.fetch()
