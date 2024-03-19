require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.describe 'Website Monitoring', type: :feature do
  before(:each) do
    # Setup Capybara session
    Capybara.register_driver :firefox_headless do |app|
      options = Selenium::WebDriver::Firefox::Options.new
      options.add_argument('--headless')
      Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
    end
    Capybara.default_driver = :firefox_headless
  end

  it 'checks homepage readability' do
    visit('https://www.rate-my-agent.com/')
    target_text_h1 = find(:xpath, "/html/body/div[2]/div/div[2]/div[2]/div/div/div/div/h1").text
    expected_text_h1 = "❤️ Your Realtor: Hire the Right Real Estate Agent in 2024"
    expect(target_text_h1).to eq(expected_text_h1)
  end

  it 'checks button navigation' do
    visit('https://www.rate-my-agent.com/')
    find('.btn-home-getmatched', wait: 30).click
    expected_url = "https://www.rate-my-agent.com/quiz?cta=take-quiz-home"
    expect(page.current_url).to eq(expected_url)
  end

  it 'searches for an agent and verifies results' do
    visit('https://www.rate-my-agent.com/')
    fill_in 'term', with: 'Lucie Martel'
    find(".btn-search", wait: 30).click
    expect(page).to have_css('.page-title', text: 'Lucie Martel')
  end
end
