# Rate-My-Agent Website Monitoring Script


## Setup and Usage

1. **Installation**:
   - **Ruby**: If Ruby is not already installed, you can download and install it from [here](https://www.ruby-lang.org/en/downloads/).
   - **Firefox**: Install Firefox by running the following command:
     ```bash
     sudo apt install firefox
     ```
   - **GeckoDriver**: Verify if GeckoDriver is installed by running:
     ```bash
     geckodriver --version
     ```
     If GeckoDriver is not installed, you can download it from the official GitHub repository: [GeckoDriver Releases](https://github.com/mozilla/geckodriver/releases). After downloading, you need to add the GeckoDriver executable to your system PATH.
   - **Required Gems**: Install the necessary Ruby gems using the following command:
     ```bash
     gem install capybara selenium-webdriver
     ```
     Additionally, add the following lines to your Gemfile if you're using Bundler:
     ```ruby
     gem 'capybara'
     gem 'rspec'
     ```
     Then, run `bundle install` to install the gems specified in the Gemfile.

## Configuration

1. **Update SMTP Server Settings**:
   - Open the script `website_monitoring_script.rb` in a text editor.
   - Locate the SMTP server settings and update them to match your environment. This includes the server address, port, and any authentication settings required by your email provider.

2. **Update Email Credentials**:
   - Within the script `website_monitoring_script.rb`, locate the section where email credentials are specified.
   - Replace `'your_email@gmail.com'` with your actual email address.
   - Replace `'your_password'` with your email password.

3. **Gmail Users: Generate App Password (if needed)**:
   - If you're using Gmail, due to enhanced security features, you may need to generate an app password specifically for this script.
   - Go to your Google Account settings and navigate to the "Security" section.
   - Look for the "App passwords" or "Less secure app access" option. You may need to enable this feature.
   - Generate a new app password and use it in place of your regular Gmail password in the script.

4. **Save Changes**:
   - Save the changes made to the `website_monitoring_script.rb` file after updating the SMTP server settings, sender, and recipient email addresses, as well as any required email credentials.


3. **Running the Script**:
   - Run the script using `ruby website_monitoring_script.rb`.

4. **Cron Job**

To schedule the script to run every 3 minutes, follow these steps:

```bash
# Open Terminal
crontab -e

# Add Cron Job
*/3 * * * * /path/to/ruby /path/to/website_monitoring_script.rb

# Save and Exit
# Press Ctrl + X, then Y, and finally Enter

# Verify Cron Job
crontab -l

# Ensure Cron Service is Running
sudo service cron start
 ```

## Execution:
   - Run the script (`ruby website_monitoring_script.rb`) to start monitoring the website.
   - Review log files in the `logs` directory for test results.
   - Check email for notifications if any tests fail.

## Approach to the Problem
1. **Understanding Requirements**: Identified critical functionalities for monitoring.
2. **Selecting Technologies**: Utilized Capybara and Selenium for web automation.
3. **Script Design**: Developed checks reflecting user interactions accurately.
4. **Error Handling**: Implemented error handling using rescue without retry, ensuring uninterrupted monitoring with comprehensive error checking and recovery mechanisms..
5. **Logging and Reporting**: Integrated logging and email notifications.
6. **Optimization**: Ensured script efficiency and resource usage.
7. **Testing**: Conducted thorough testing under three specific scenarios to validate the functionality and reliability of the monitoring script. 
8. **Continuous Improvement**: Adopted an iterative approach for ongoing enhancements.

## Your Thinking
Throughout the project, I prioritized reliability, efficiency, and maintainability. This included careful consideration of technology choices, error handling strategies, and optimization techniques. I also emphasized proactive monitoring and iterative improvements to ensure the script meets evolving requirements and maintains its effectiveness over time.

## Design Choices
- **Capybara and Selenium**: Chosen for their robust web automation capabilities.
- **Headless Firefox**: Used for automated tasks without GUI.
- **Email Notifications**: Prompt alerts in case of website issues.
- **Logging**: Facilitates troubleshooting with detailed logs.

## Pitfalls Seen and Avoided
- **Website Structure Dependency**: Mitigated disruptions from layout changes with robust selectors and error handling.
- **Network Connectivity**: Ensured script resilience against potential network interruptions.
- **Resource Consumption**: Optimized script to minimize resource usage and prevent performance issues.

## Conclusion
The Rate-My-Agent Website Monitoring Script offers a reliable solution for monitoring Rate-My-Agent.com, ensuring continuous availability and functionality. With email notifications, logging, and scheduled checks, administrators can proactively maintain the website's operational status.
