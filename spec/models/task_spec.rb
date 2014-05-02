require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.create :task }

  it { expect(task).to validate_presence_of :name }
  it { expect(task).to validate_numericality_of :priority }
  # it { should ensure_inclusion_of(:complete).in_array([true, false]) }

  context 'relations' do
    it { expect(task).to belong_to :user }
  end

  context 'scopes' do
    it 'return list of tasks' do
      user = FactoryGirl.create :user
      tasks = FactoryGirl.create_list :task, 5, user: user
      expect(Task.by_user(user)).to match_array tasks
    end
  end
end