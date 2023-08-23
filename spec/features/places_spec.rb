require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return(
      stub_request(:get, /.*kumpula/).to_return(body: '', headers: { 'Content-Type' => "application/json" })
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, they are all shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Lintula", id: 2 ) ]
    )

    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return(
      stub_request(:get, /.*kumpula/).to_return(body: '', headers: { 'Content-Type' => "application/json" })
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Lintula"
  end

  it "if none are returned by the API, a notice is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )

    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return(
      stub_request(:get, /.*kumpula/).to_return(body: '', headers: { 'Content-Type' => "application/json" })
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end

end
