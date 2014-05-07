describe "Views.TasksIndex", ->
  view = tasks = {}

  beforeEach ->
    setFixtures '''
                    <div id="app">
                      <div>Add Task: <input id="add-task" autofocus='true' type="text"/></div>
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

      it "tasks count eq 1", ->
        #//expect($('#task-count').text()).toEqual('1')
