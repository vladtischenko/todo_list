require 'spec_helper'

describe TasksController do
  include Devise::TestHelpers

  let(:task) { FactoryGirl.create :task }
  let(:task_params) {{"name"=>task.name, "complete"=>task.complete, "priority"=>task.priority}}

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create :user
    sign_in @user
  end

  before do
    @tasks = FactoryGirl.create_list :task, 1, user: @user
    @json = {format: :json, task: {name: task.name, complete: task.complete, priority: task.priority}}
    Task.stub(:by_user).and_return(@tasks)
  end

  context 'GET index' do
    it 'render json tasks' do
      get :index, format: :json
      expect(JSON.parse(response.body).to_json).to eq @tasks.to_json
    end
  end

  context 'POST create' do
    it 'render json task if successfully' do
      post :create, @json
      expect(JSON.parse(response.body)['name']).to eq(@json[:task][:name])
    end
    it 'render json task.errors unless successfully' do
      @json[:task][:name] = nil
      post :create, @json
      expect(JSON.parse(response.body)['name']).to eq ["can't be blank"]
    end
  end

  context 'PATCH update' do
    it 'render json task if successfully' do
      patch :update, id: task.id, task: task_params, format: :json
      expect(JSON.parse(response.body)['name']).to eq (@json[:task][:name])
    end
    it 'render json task.errors unless successfully' do
      task_params['name'] = nil
      patch :update, id: task.id, task: task_params, format: :json
      expect(JSON.parse(response.body)['name']).to eq ["can't be blank"]
    end
  end

  context 'DELETE destroy' do
    it { expect { delete :destroy, format: :json, id: task.id }.to change(Task, :count).by(-1) }
  end

end
