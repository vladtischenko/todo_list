describe "Views.AllComplete", ->
  view = tasks = {}

  beforeEach ->
    setFixtures '''
                    <div id="all_complete">
                      <div>
                        <% if @all: %>
                          <input id="complete" type="checkbox" checked="true" />
                        <% else: %>
                          <input id="complete" type="checkbox" />
                        <% end %>
                        <span id="mark_all">mark all as complete</span>
                      </div>
                    </div>
                  '''
  tasks = new TodoList.Collections.Tasks
  view = new TodoList.Views.AllComplete collection: tasks

  afterEach ->
    tasks = []

  describe "display elements", ->
    it "show checkbox", ->
      expect($('#all_complete')).toContain('input#complete')

    it "show label", ->
      expect($('#all_complete')).toContain($('#mark_all'))

    it "have text", ->
      expect($('#mark_all').text()).toEqual("mark all as complete")

  describe "all tasks", ->
    #//it "checkbox is not checked when any task is not complete", ->
    #//it "checkbox is checked when all tasks are complete", ->
