require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures name of user is present' do
      user = User.new(email: 'user@gmail.com', password: 'password')
      expect(user.valid?).to be(false)
    end

    it 'ensures minimum length for name to be 3' do
      user = User.new(name: 'Us', email: 'user@gmail.com', password: 'password')
      expect(user.valid?).to be(false)
    end

    it 'ensures max length for name to be 20' do
      user = User.new(name: 'Jesus Christ of Jerusalem and Bethlehem', email: 'user@gmail.com', password: 'password')
      expect(user.valid?).to be(false)
    end

    it 'should save successfully' do
      user = User.new(name: 'User1', email: 'user@gmail.com', password: 'password')
      expect(user.valid?).to be(true)
    end
  end

  context 'helper methods test' do
    before(:each) do
      @user1 = User.create(name: 'User1', email: 'user1@gmail.com', password: 'password')
      @user2 = User.create(name: 'User2', email: 'user2@gmail.com', password: 'password')
    end

    it 'should return empty friends' do
      expect(@user1.friends.empty?).to eq(true)
    end

    it 'should return one incoming friend request' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      expect(@user2.friend_requests.length).to eq(1)
    end

    it 'should return one pending friend request' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      expect(@user1.pending_friends.length).to eq(1)
    end

    it 'should confirm the incoming friend request' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      @user2.confirm_friend(@user1)
      expect(@user1.friendships.first.confirmed).to eq(true)
    end

    it 'should affirm another user as a friend' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      @user2.confirm_friend(@user1)
      expect(@user1.friend?(@user2)).to eq(true)
    end
  end
end