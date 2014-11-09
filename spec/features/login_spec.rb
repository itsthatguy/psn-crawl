describe "Playstation Store", js: true  do
  include Capybara::DSL
  LOGIN_USERNAME = ENV['LOGIN_USERNAME']
  LOGIN_PASSWORD = ENV['LOGIN_PASSWORD']
  LOGIN_URL = 'https://auth.api.sonyentertainmentnetwork.com/login.jsp'
  FREE_GAMES_URL = 'https://store.sonyentertainmentnetwork.com/#!/en-us/free-games/cid=STORE-MSF77008-PSPLUSFREEGAMES'

  def goto_free_games_page
    visit(FREE_GAMES_URL)
    find('.lastCell', wait: 10)
  end

  before do
    visit(LOGIN_URL)
    fill_in('j_username', with: LOGIN_USERNAME)
    fill_in('j_password', with: LOGIN_PASSWORD)
    click_on('Sign In')
  end

  context 'Free Games Page' do
    let(:free_games) do
      page.find('.addToCartBtn', wait: 10)
      page.all('.cellGridGameStandard')
    end

    before { goto_free_games_page }

    it 'finds games' do
      games_to_purchase = free_games.reject do |game|
        game[:class].include? 'ownAlready'
      end

      expect(games_to_purchase.length).to be < free_games.length

      games_to_purchase.each do |game|
        game.find('.addToCartBtn').click
        page.find('.modal-confirm .yesText').click
        page.find('.DialogAddedToCart .contShopBtn').click
      end

      page.find('.headerUserCart').click
      page.find('.checkoutContainer .proceedBtn')
      binding.pry
      page.find('.pageCartConfirm').click_on('Confirm Purchase')
    end
  end

end

# id="appRoot" class=" app useColorShield mediaType-game branded-bckgnd enableStickyFooter"
# id="appRoot" class=" app useColorShield mediaType-game branded-bckgnd enableStickyFooter"
