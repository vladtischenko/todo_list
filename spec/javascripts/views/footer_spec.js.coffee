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

  describe "model bind events", ->
    it "rerender when collection changes", ->
      view.render()
      expect(el).toContain('span#task-count')
