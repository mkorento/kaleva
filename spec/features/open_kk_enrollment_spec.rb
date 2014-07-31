require 'spec_helper'

include SigninHelper

feature 'Opening enrollment' do
  let!(:user) { FactoryGirl.create :user, :admin, password: 'Salainen1',
      password_confirmation: 'Salainen1' }
  before :each do
    sign_in(username: 'Tyhjis', password: 'Salainen1')
  end

  context 'Closed enrollment' do
    scenario 'User tries to enroll' do
      click_link 'Esittely'
      click_link 'Ilmoittautuminen'
      expect(page).not_to have_link 'Ilmoittaudu kierrokselle'

      visit new_kk_enrollment_path(user.id)
      expect(page).to have_content 'Kierrokselle ei voi ilmoittautua'
    end

    scenario 'Admin opens enrollment' do
      click_link 'Kierroksen hallinta'
      click_button 'Avaa ilmoittautuminen'
      expect(current_url).to eq(admin_kk_enrollment_url)
      expect(page).to have_content 'Kierrosilmoittautuminen avattu'

      visit new_kk_enrollment_path(user.id)
      expect(page).to have_content 'Ilmoittautuminen Kalevan Kierrokselle'
    end
  end

  context 'Open enrollment' do
    before :each do
      click_link 'Kierroksen hallinta'
      click_button 'Avaa ilmoittautuminen'
    end

    scenario 'User creates new enrollment' do
      click_link 'Esittely'
      click_link 'Ilmoittautuminen'
      click_link 'Ilmoittaudu kierrokselle'
      expect(Result.count).to eq(0)
      click_button 'Ilmoittaudu kierrokselle'
      expect(page).to have_content 'Ilmoittautuminen onnistui'
      expect(page).not_to have_content 'Kierrokselle ei voi ilmoittautua'
      expect(Result.count).to eq(1)
    end

    scenario 'User enrollment creates new result entry' do
      click_link 'Esittely'
      click_link 'Ilmoittautuminen'
      click_link 'Ilmoittaudu kierrokselle'
      click_button 'Ilmoittaudu kierrokselle'
      expect(Result.last.name).to eq(user.full_name)
      expect(Result.last.year).to eq(Date.today.year)
      expect(Result.last.city).to eq(user.city)
    end
  end
end
