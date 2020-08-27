require 'rails_helper'

RSpec.describe Post, type: :model do
    let(:user) { User.create(name: 'User1', email: 'user1@gmail.com', password: 'password') }
  subject { Post.new(user_id: user.id, content: 'Test post') }

  context 'Validation' do
    it 'Should validate presence of content' do
      subject.content = nil
      expect(subject.valid?).to be false
    end

    it 'Should validate presence of content' do
      subject.content = 'ni'
      should validate_length_of(:content).is_at_least(3)
    end
  end

  context 'Associations' do
    it 'should have a comments array' do
      expect(subject.comments).to_not be_nil
    end

    it 'should have a likes array' do
      expect(subject.likes).to_not be_nil
    end
    it 'should have a user' do
      subject.save
      expect(subject.user).to_not be_nil
    end
  end
end
