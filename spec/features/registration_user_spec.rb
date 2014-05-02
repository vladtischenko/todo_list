require 'features/features_spec_helper'

feature "Sing in / Sing up", :js => true do
   scenario "User sign up" do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', with: 'pupkin@example.com'
      fill_in 'Password', with: 'qweasdzxc'
      fill_in 'Password confirmation', with: 'qweasdzxc'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Add Task'
  end
  
  context 'registered user' do
    background do
      @user = User.create(email: 'pupkin@example.com',
        password: 'qweasdzxc', password_confirmation: 'qweasdzxc')
    end
    scenario "User long in" do
      visit new_user_session_path
      within '#new_user' do
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
      end
      click_button 'Sign in'
      expect(page).to have_content 'Add Task'
    end
  end

end