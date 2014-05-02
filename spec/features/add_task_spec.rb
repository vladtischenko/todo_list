require 'features/features_spec_helper'

feature "Add Task", :js => true do
  background do
    # @user = User.create(email: 'pupkin@example.com',
      # password: 'qweasdzxc', password_confirmation: 'qweasdzxc')
    # login_as @user, scope: :user
  end

  scenario 'user add task to list' do
    
    #------------------------------
    # visit new_user_registration_path
    # within '#new_user' do
      # fill_in 'Email', with: 'pupkin@example.com'
      # fill_in 'Password', with: 'qweasdzxc'
      # fill_in 'Password confirmation', with: 'qweasdzxc'
    # end
    # click_button 'Sign up'
    #------------------------------

    # visit tasks_path
    # el = find(:xpath, "//input[@name='add-task']")
    # el.set('some new task')
    # el.native.send_keys(:return)
    # fill_in "input#add-task", with: 'some new task'
    # click_button 'enter'
    # expect(page).to have_content 'some new task'
  end
end