require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'User1', email: 'user1@gmail.com', password: 'password') }
  let(:post) { Post.create(user_id: user.id, content: 'Test post') }
  subject { Comment.create(user_id: user.id, post_id: post.id) }

  context 'Associations' do
    it 'should have a user' do
      expect(subject.user).to_not be_nil
    end

    it 'should have a post' do
      expect(subject.post).to_not be_nil
    end
  end
end
