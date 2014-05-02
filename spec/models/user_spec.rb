require 'spec_helper'

describe User do
  let(:user) {FactoryGirl.create :user}

  it { expect(user).to validate_presence_of :email }
  it { expect(user).to validate_uniqueness_of :email }

  context 'relations' do
    it { expect(user).to have_many :tasks }
  end
end