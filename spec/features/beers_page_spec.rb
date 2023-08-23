require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:user) { FactoryBot.create :user }
  let!(:style) { FactoryBot.create :style, name: "European Pale Lager" }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "can be added with a valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'Karhu')
    select('European Pale Lager', from: 'beer[style_id]')
    select('Koff', from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "cannot be added with an invalid name" do
    visit new_beer_path
    select('Lager', from: 'beer[style_id]')
    select('Koff', from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to_not change{Beer.count}
  end
end