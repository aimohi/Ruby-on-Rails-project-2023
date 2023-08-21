require 'rails_helper'

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
  
    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'      
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')
    
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end

    it "has own ratings shown on user's page" do
      sign_in(username: "Pekka", password: "Foobar1")
      user2 = FactoryBot.create(:user, username: "anonymous")
      brewery = FactoryBot.create(:brewery)
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beer_with_rating({user: User.first}, 10)
      create_beer_with_rating({user: user2}, 20)
      visit user_path(User.first)

      expect(page).to have_content 'Has made 1 rating'
      expect(page).to have_content 'anonymous 10'
    end

    it "has rating removed from database when user deletes it" do
      sign_in(username: "Pekka", password: "Foobar1")
      user2 = FactoryBot.create(:user, username: "anonymous")
      brewery = FactoryBot.create(:brewery)
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beer_with_rating({user: User.first}, 10)
      create_beer_with_rating({user: user2}, 20)
      visit user_path(User.first)

      page.first(:link, "Delete").click
      visit user_path(User.first)
      expect(page).to have_content 'Has made 0 ratings'
    end

    it "has favorite style shown on user's page" do
      sign_in(username: "Pekka", password: "Foobar1")
      brewery = FactoryBot.create(:brewery)
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beer_with_rating({user: User.first}, 10)
      visit user_path(User.first)

      expect(page).to have_content 'Favorite style is Lager'
    end

    it "has favorite brewery shown on user's page" do
      sign_in(username: "Pekka", password: "Foobar1")
      brewery = FactoryBot.create(:brewery)
      beer = FactoryBot.create(:beer, brewery: brewery)
      create_beer_with_rating({user: User.first}, 10)
      visit user_path(User.first)

      expect(page).to have_content 'Favorite brewery is anonymous'
    end
  end
end