require 'rails_helper'

RSpec.feature 'Viewing someone elses profile', type: :feature do
  let(:user) { FactoryGirl.create(:user, name: 'Elon') }

  let!(:game1) do
    FactoryGirl.create(
      :game, user: user, created_at: Time.parse('2021.01.01, 12:00'), current_level: 5, prize:1000,
        finished_at: Time.parse('2021.01.01, 14:00')
    )
  end

  let!(:game2) do
    FactoryGirl.create(
      :game, user: user, created_at: Time.parse('2021.01.02, 15:00'), current_level: 13, prize: 500_000
    )
  end

  scenario 'successfully' do
    visit '/'

    click_link 'Elon'

    expect(page).to have_current_path '/users/1'
    expect(page).to have_content 'Elon'

    expect(page).not_to have_content 'Сменить имя и пароль'

    expect(page).to have_content '01 янв., 12:00'
    expect(page).to have_content '02 янв., 15:00'

    expect(page).to have_content 'деньги'
    expect(page).to have_content 'в процессе'

    expect(page).to have_content '1 000 ₽'
    expect(page).to have_content '500 000 ₽'

    expect(page).to have_content '50/50'
    expect(page).to have_css '.label-primary'
  end
end
