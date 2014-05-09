describe "Views.Footer", ->
  view = el = tasks = {}

  beforeEach ->
    setFixtures '''
                  <div id="footer"></div>
                '''
    tasks = new TodoList.Collections.Tasks
    view = new TodoList.Views.Footer(collection: tasks)
    el = $(view.el)

  afterEach ->
    tasks = []

  it "is contained 'div' by default element", ->
    expect(view.el.nodeName).toEqual('DIV')

  it "collection count eq 1", ->
    task = new TodoList.Models.Task
    task.url = '/task'
    task.set({name: 'some task', complete: false, priority: 0}).save()
    tasks.add(task)
    view.render()
    expect($('#task-count').text()).toEqual('1')

  describe "model bind events", ->
    it "rerender when collection changes", ->
      view.render()
      expect(el).toContain('#task-count')
