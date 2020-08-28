require 'rails_helper'

RSpec.feature 'User', type: :feature do
  before :each do
    User.create(name: 'test', email: 'test@email.com', password: 'password', password_confirmation: 'password')
  end
  scenario 'Authenticates User' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'invalid@email.com'
    fill_in 'user[password]', with: 'password'
    click_button 'commit'

    expect(page).to have_text('Invalid Email or password.')
  end

  scenario 'User can log in and see and recent posts' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'test@email.com'
    fill_in 'user[password]', with: 'password'
    click_button 'commit'

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text('Recent posts')
  end

  scenario 'User can view all users' do
    user = User.create(name: 'test', email: 'test3@email.com', password: 'password', password_confirmation: 'password')
    sign_in user

    visit '/users'

    expect(page).to have_text('Name: test')
    # expect(page).to have_text("Recent posts")
  end

  scenario 'User can create post' do
    user = User.create(name: 'test', email: 'test1@email.com', password: 'password', password_confirmation: 'password')

    sign_in user

    visit '/posts'
    within('#new_post') do
      fill_in 'post[content]', with: 'test post'
      click_button 'commit'
    end

    expect(page).to have_text('Post was successfully created.')
  end

  scenario 'User can send friend request' do
    user = User.create(name: 'test', email: 'test8@email.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'test', email: 'test9@email.com', password: 'password', password_confirmation: 'password')

    sign_in user

    visit '/users'

    click_link(user2.id.to_s)

    expect(page).to have_text('Freind Request sent')
  end

  scenario 'User can accept friend request' do
    user = User.create(name: 'test', email: 'test6@email.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'test', email: 'test7@email.com', password: 'password', password_confirmation: 'password')
    sign_in user
    visit '/users'
    click_link(user2.id.to_s)
    click_link('Sign out')
    sign_in user2
    visit '/users'
    click_link('Requests')
    click_link('accept_friend_link')

    expect(page).to have_text('Friend request accepted')
  end

  scenario 'User can accept friend request' do
    user = User.create(name: 'test', email: 'test6@email.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'test', email: 'test7@email.com', password: 'password', password_confirmation: 'password')
    sign_in user
    visit '/users'
    click_link(user2.id.to_s)
    click_link('Sign out')
    sign_in user2
    visit '/users'
    click_link('Requests')
    click_link('reject_friend_link')

    expect(page).to have_text('Friend request rejected')
  end
end
