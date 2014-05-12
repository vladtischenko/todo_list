describe "Views.TasksIndex", ->
  view = tasks = {}

  beforeEach ->
    setFixtures '''
                    <div id="app">
                      <div><input id="add-task" autofocus='true' type="text" placeholder="Type the new task..."/></div>
                      <div id="all_complete"></div>
                      <div id="tasks"></div>
                      <div id="footer"></div>
                    </div>
                  '''
    tasks = new TodoList.Collections.Tasks
    view = new TodoList.Views.TasksIndex collection: tasks

    allCompleteView = new TodoList.Views.AllComplete collection: tasks
    allCompleteView.render()

    footerView = new TodoList.Views.Footer collection: tasks
    footerView.render()


  afterEach ->
    tasks = []

  it "is contained 'div' by default element", ->
    expect(view.el.nodeName).toEqual('DIV')

  describe "rendered index template", ->
    it "have checkbox 'make all as complete'", ->
      expect($('#app')).toContain('input#complete')

    it "have tasks count", ->
      expect($('#app')).toContain('span#task-count')

    describe "when no tasks are present", ->
      it "doesn't contain #task-name", ->
        expect($('#app')).toContain('input#add-task')
        expect($('#app')).not.toContain('#task-name')

    describe "when tasks are present", ->
      beforeEach ->
        task = new TodoList.Models.Task
        task.url = '/task'
        task.set({name: "some name", complete: false, priority: 0}).save()
        tasks.add(task)

      it "display task name", ->
        expect($('#app')).toContain('#task-name')

  describe "collection bind events", ->
    it "rerenders collection when it changes", ->
      expect($('#app')).not.toContain('#task-name')
      task = new TodoList.Models.Task
      task.url = '/task'
      task.set({name: 'some name', complete: false, priority: 0}).save()
      tasks.add(task)
      expect($('#app')).toContain('#task-name')

  describe "display task", -> 
    it "added task", ->
      $('#add-task').val("some new task").trigger($.Event('keypress', keyCode: 13))
      expect($('#task-name').text()).toEqual("some new task")

    it "edit field", ->
      task = new TodoList.Models.Task
      task.url = '/task'
      task.set({name: 'some name', complete: false, priority: 0}).save()
      tasks.add(task)
      $('#task-name').trigger('dblclick')
      expect($('#tasks')).toContain('input#edit-task')

  describe "actions task", ->
    beforeEach ->
      task = new TodoList.Models.Task
      task.url = '/task'
      task.set({name: 'some name', complete: false, priority: 0}).save()
      tasks.add(task)

    it "remove task", ->
      expect($('#tasks')).toContain('#task-name')
      $('#remove-task').trigger('click')
      expect($('#tasks')).not.toContain('#task-name')

    it "mark task as complete", ->
      expect($('#tasks')).not.toContain('strike#task-name')
      $('#task-complete').trigger('click')
      expect($('#tasks')).toContain('strike#task-name')

    it "edit task", ->
      expect($('#task-name').text()).toEqual('some name')
      $('#task-name').trigger('dblclick')
      $('input#edit-task').val('my task').trigger($.Event('keypress', keyCode: 13))
      expect($('#task-name').text()).toEqual('my task')
