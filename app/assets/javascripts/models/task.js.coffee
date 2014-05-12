class TodoList.Models.Task extends Backbone.Model

  changePriority: (model_id) ->
    current_task = @collection.findWhere(id: model_id)
    
    current_priority = current_task.get('priority')

    task_priorities = []
    @collection.each (task) =>
      task_priorities.push(task.get('priority'))

    tasks_to_change_priority = []
    tasks_to_change_priority = _.filter(task_priorities, (priority) ->
      priority > current_priority)

    tasks = new TodoList.Collections.Tasks
    for priority in tasks_to_change_priority
      tasks.add(@collection.findWhere(priority: priority))

    tasks.each (task) =>
      task.set({priority: task.get('priority') - 1}).save()

  drag: (first_id, second_id) ->
    first_task = @collection.findWhere(id: first_id)
    second_task = @collection.findWhere(id: second_id)

    priority_first = first_task.get 'priority'
    priority_second = second_task.get 'priority'

    return if priority_first == priority_second

    task_priorities = []
    @collection.each (task) =>
      task_priorities.push(task.get('priority'))

    middle_task_priorities = []
    if priority_first < priority_second 
      middle_task_priorities = _.filter(task_priorities, (priority) -> 
        priority > priority_first && priority < priority_second
        )
    else
      middle_task_priorities = _.filter(task_priorities, (priority) ->
        priority < priority_first && priority > priority_second
        )

    tasks = new TodoList.Collections.Tasks
    for priority in middle_task_priorities
      tasks.add(@collection.findWhere(priority: priority), {sort: false})

    if priority_first < priority_second
      tasks.each (task) =>
        task.set({priority: task.get('priority') - 1}).save()
      first_task.set({priority: second_task.get('priority')}).save()
      second_task.set({priority: second_task.get('priority') - 1}).save()
    else
      tasks.each (task) =>
        task.set({priority: task.get('priority') + 1}).save()
      first_task.set({priority: second_task.get('priority')}).save()
      second_task.set({priority: second_task.get('priority') + 1}).save()
