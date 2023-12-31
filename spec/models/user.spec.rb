require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'test', email: 'test@test.com', password: '123456')
  end
  before { subject.save }

  describe 'validate data' do
    it 'should has a valid username' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should has a valid email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'should has a valid password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end
end
