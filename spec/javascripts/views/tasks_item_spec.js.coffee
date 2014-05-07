describe "Views.TasksItem", ->
  view = el = task = {}

  beforeEach ->
    TodoList.Tasks = new TodoList.Collections.Tasks
    task = new TodoList.Models.Task
    task.url = '/task'
    view = new TodoList.Views.TasksItem(model: task)
    el = $(view.el)

  afterEach ->
    #//TodoList.Tasks.localStorage.records = []
    TodoList.Tasks = []

  it "is contained 'div' by default element", ->
    expect(view.el.nodeName).toEqual('DIV')

  describe "model bind events", ->
    it "rerenders when model changes", ->
      expect(el).not.toContain('strike#task-name')
      task.set(complete: true)
      expect(el).toContain('strike#task-name')

    it "destroy when model remove", ->
      setFixtures('<ul id="foo"></ul>')
      $('#foo').html(view.render().el)
      expect($('#foo')).toContain('div#task')
      task.destroy()
      expect($('#foo')).not.toContain('div#task')

  describe "on create display", ->
    beforeEach ->
      task.save(name: 'some task')
      setFixtures('<ul id="foo"></ul>')
      $('#foo').html(view.render().el)

    it "show task name in span#task-name", ->
      expect($('span#task-name', el).text()).toEqual('some task')

    it "show input field when double click task name for edit task", ->
      $('#task-name').dblclick()
      expect($('#foo')).toContain('input#edit-task')
    
    it "show task name in the input field", ->
      $('#task-name').dblclick()
      expect($('input#edit-task', el).val()).toEqual('some task')

  describe "toggle task", ->
    it "toggle complete on the task", ->
      setFixtures('<ul id="foo"></ul>')
      $('#foo').html(view.render().el)
      $('#task-complete').click()
      expect($('#foo')).toContain('strike#task-name')
