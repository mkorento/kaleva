require 'spec_helper'

include SigninHelper

describe "New Event page" do
  let!(:user) { FactoryGirl.create :user, password:"S4lainen", password_confirmation:"S4lainen", admin:true}
  before :each do
    sign_in(username:"Tyhjis", password:"S4lainen")
    visit new_event_path
  end


  it "should contain correct heading" do
    expect(page).to have_content "Luo uusi tapahtuma"
  end

  describe "should create" do
    before :each do
      select '1', :from => 'event_start_date_3i'
      select 'tammikuu', :from => 'event_start_date_2i'
      select '2015', :from => 'event_start_date_1i'
      select '1', :from => 'event_end_date_3i'
      select 'helmikuu', :from => 'event_end_date_2i'
      select '2015', :from => 'event_end_date_1i'
    end

    it "a new default event correctly" do
      select "Tyhjä", :from => 'type'
      fill_in "event_name", with: "tyhjatapahtuma"
      fill_in "event_description", with: "Kuvausta"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Tapahtuma luotu onnistuneesti"
    end

    it "a new running event correctly" do
      select "Juoksu", :from => 'type'
      fill_in "event_name", with: "Juoksutapahtuma"
      fill_in "event_description", with: "Juoksukuvaus"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Juoksutapahtuma luotu onnistuneesti"
    end

    it "a new rowing event correctly" do
      select "Soutu", :from => 'type'
      fill_in "event_name", with: "Soututapahtuma"
      fill_in "event_description", with: "Soutukuvaus"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Soututapahtuma luotu onnistuneesti"
    end

    it "a new skating event correctly" do
      select "Luistelu", :from => 'type'
      fill_in "event_name", with: "Luistelutapahtuma"
      fill_in "event_description", with: "Luistelutapahtuma"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Luistelutapahtuma luotu onnistuneesti"
    end

    it "a new skiing event correctly" do
      select "Hiihto", :from => 'type'
      fill_in "event_name", with: "Hiihtotapahtuma"
      fill_in "event_description", with: "Hiihtokuvaus"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Hiihtotapahtuma luotu onnistuneesti"
    end

    it "a new orienteering event correctly" do
      select "Suunnistus", :from => 'type'
      fill_in "event_name", with: "Suunnistustapahtuma"
      fill_in "event_description", with: "Suunnistuskuvaus"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Suunnistustapahtuma luotu onnistuneesti"
    end

    it "a new cycling event correctly" do
      select "Pyöräily", :from => 'type'
      fill_in "event_name", with: "Pyöräilytapahtuma"
      fill_in "event_description", with: "Pyöräilykuvaus"
      click_button "Luo tapahtuma"
      expect(page).to have_content "Pyöräilytapahtuma luotu onnistuneesti"
    end

  end

  describe "should not create" do

    it "a new event without any of the required fields" do
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new event without missing name field" do
      make_selects_for_dates
      fill_in "event_description", with: "Kuvaus"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new running event without missing name field" do
      make_selects_for_dates
      select "Juoksu", :from => 'type'
      fill_in "event_description", with: "Juostaan"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new rowing event without missing name field" do
      make_selects_for_dates
      select "Soutu", :from => 'type'
      fill_in "event_description", with: "Soudetaan"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new skating event without missing name field" do
      make_selects_for_dates
      select "Luistelu", :from => 'type'
      fill_in "event_description", with: "Luistellaan"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new skiing event without missing name field" do
      make_selects_for_dates
      select "Hiihto", :from => 'type'
      fill_in "event_description", with: "Hiihdetään"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new cycling event without missing name field" do
      make_selects_for_dates
      select "Pyöräily", :from => 'type'
      fill_in "event_description", with: "Pyöräillään"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    it "a new orienteering event without missing name field" do
      make_selects_for_dates
      select "Suunnistus", :from => 'type'
      fill_in "event_description", with: "Suunnistetaan"
      click_button "Luo tapahtuma"
      expect(page).to have_content "error prohibited this event from being saved"
    end

    def make_selects_for_dates
      select '1', :from => 'event_start_date_3i'
      select 'tammikuu', :from => 'event_start_date_2i'
      select '2015', :from => 'event_start_date_1i'
      select '1', :from => 'event_end_date_3i'
      select 'helmikuu', :from => 'event_end_date_2i'
      select '2015', :from => 'event_end_date_1i'
    end
  end

end