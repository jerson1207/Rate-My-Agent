require 'capybara'
require 'selenium-webdriver'
require 'net/smtp'

Capybara.register_driver :firefox_headless do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument('--headless')
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.default_driver = :firefox_headless

def monitor_website
  session = Capybara::Session.new(:firefox_headless) 
  session.visit('https://www.rate-my-agent.com/') 
  
  check_homepage_readability(session)
  check_button_navigation(session)
  search_for_agent_and_verify_results(session)
rescue => e
  puts "Error accessing website: #{e.message}"
  send_email("Error accessing website: #{e.message}")
end

def check_homepage_readability(session)
  target_text_h1 = session.find(:xpath, "/html/body/div[2]/div/div[2]/div[2]/div/div/div/div/h1").text
  expected_text_h1 = "❤️ Your Realtor: Hire the Right Real Estate Agent in 2024"
  if target_text_h1 == expected_text_h1
    puts "Home page readability check passed successfully."
  else
    puts "Home page readability check failed"
    send_email("Home page readability check failed: Expected '#{expected_text_h1}', but found '#{target_text_h1}'")
  end
  create_log_file('Home page readability check log', target_text_h1 == expected_text_h1)
end

def check_button_navigation(session)
  button = session.find('.btn-home-getmatched', wait: 30)
  button.click

  expected_url = "https://www.rate-my-agent.com/quiz?cta=take-quiz-home"

  if session.current_url == expected_url
    puts "Button navigation check passed successfully."
  else
    puts "Button navigation check failed"
    send_email("Button navigation check failed: Expected URL '#{expected_url}', but found '#{session.current_url}'")
  end
  create_log_file('Button navigation check log', session.current_url == expected_url)
end

def search_for_agent_and_verify_results(session)
  session.visit('https://www.rate-my-agent.com/')
  sleep 5
  agent_name =  'Lucie Martel'
  session.fill_in('term', with: agent_name)
  session.find(".btn-search", wait: 30).click
  page_title_element = session.find('.page-title')

  if page_title_element.text.include?(agent_name)
    puts "Agent search and verification check passed successfully."
  else
    puts "Agent search and verification check failed"
    send_email("Agent search and verification check failed: Expected agent name '#{agent_name}' to be included in page title, but it was not.")
  end
  create_log_file('Agent search and verification check passed log', page_title_element.text.include?(agent_name))
end

def create_log_file(test_name, result)
  time_stamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
  folder_path = File.join(Dir.pwd, "logs")
  Dir.mkdir(folder_path) unless Dir.exist?(folder_path)
  filename = "#{test_name}_#{time_stamp}.log"
  file_path = File.join(folder_path, filename)
  File.open(file_path, 'w') do |file|
    file.puts "Test: #{test_name}"
    file.puts "Result: #{result ? 'Pass' : 'Fail'}"
    file.puts "Time stamp: #{time_stamp}"
  end
end

def send_email(message)
  # SMTP server settings
  smtp_server = 'smtp.gmail.com'
  smtp_port = 587
  smtp_domain = 'gmail.com'
  # smtp_username = 'jersonjabatstudent@gmail.com'
  from_email = 'your_email@gmail.com'
  # smtp_password = 'hqbw bfpk uydx ztbx' 
  smtp_password = 'your_password' 

  # Sender and recipient details
  # from_email = 'jersonjabatstudent@gmail.com'
  from_email = 'your_email@gmail.com'
  to_email = 'alerts@rate-my-agent.com'

  # Email content
  subject = 'Website Test Result'
  body = message

  # Construct the email message
  email_message = <<EOF
From: #{from_email}
To: #{to_email}
Subject: #{subject}

#{body}
EOF

  # Send the email
  Net::SMTP.start(smtp_server, smtp_port, smtp_domain, smtp_username, smtp_password, :login) do |smtp|
    smtp.send_message(email_message, from_email, to_email)
  end

  puts "Email sent successfully!"
rescue => e
  puts "Error sending email: #{e.message}"
end

def wait_for_element(session, selector)
  Timeout.timeout(30) do
    loop until session.has_css?(selector)
  end
end

monitor_website
