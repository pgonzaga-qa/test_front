require "eyes_capybara"
require "capybara/dsl"

extend Capybara::DSL

Capybara.configure do |config|
  config.default_max_wait_time = 15
end

runner = Applitools::ClassicRunner.new
batch = Applitools::BatchInfo.new("Demo Batch")
eyes = Applitools::Selenium::Eyes.new(runner: runner)

Applitools.register_capybara_driver :browser => :chrome

eyes.configure do |conf|
  conf.batch = batch
  conf.api_key = "nk2bnWX4pHEGK3lVS7YMHu2tygVS4eZFXNnb6kLvk108g110"
  conf.app_name = "Demo App"
  conf.test_name = "Smoke Test"
  conf.viewport_size = Applitools::RectangleSize.new(800, 600)
end

begin
  # Call Open on eyes to initialize a test session
  eyes.open(driver: page)

  # Navigate to the url we want to test
  visit("https://homolog.obramax.com.br/")

  # check the login page
  eyes.check_window("Home Page")

  find(".contact_box span").click
  find("#reasons").click

  # Check the app page
  eyes.check_window("Fale Conosco Page")
  eyes.close_async
rescue => e
  puts e.message
  eyes.abort_if_not_closed
ensure
  # Get and print all test results
  puts runner.get_all_test_results
end
