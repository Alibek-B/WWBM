require 'rails_helper'

RSpec.describe 'users/show', type: :view do

  # - пользователь видит там свое имя
  # - что текущий пользователь (и только он) видит там кнопку для смены пароля
  # - что на странице отрисовываются фрагменты с игрой


  let(:user) { FactoryGirl.create(:user, name: 'Elon') }
  let(:game) { [FactoryGirl.create(:game)] }

  context 'authorized user' do
    before(:each) do
      assign(:user, user)
      sign_in(user)
      render
    end

    it 'user sees his name' do
      expect(rendered).to match 'Elon'
    end

    it 'user sees the change password button' do
      expect(rendered).to match 'Сменить имя и пароль'
    end

    it 'visible fragment game' do
      assign(:games, game)
      stub_template 'users/_game.html.erb' => 'User game goes here'
      render

      expect(rendered).to have_content 'User game goes here'
    end
  end

  context 'not an authorized user' do
    it 'user does not see change password button' do
      expect(rendered).not_to match 'Сменить имя и пароль'
    end
  end
end
