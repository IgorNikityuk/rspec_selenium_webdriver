require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "CCCAdminTestSearch" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://staging.limos.com"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "Verify search function like admin" do
    @driver.get(@base_url)
    !60.times{ break if (@driver.title == "Limo & Car Services, Party Bus Rentals and more | Limos.com" rescue false); sleep 1 }
    @driver.find_element(:link,"Sign In").click
    @driver.find_element(:id,"email").send_keys "joyce2@limos.com"
    @driver.find_element(:id,"password").send_keys "password"
    @driver.find_element(:id,"signin_btn").click
    @driver.find_element(:link,"Admin Test").click

    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "service_type")).select_by(:text, "To Airport")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "search_pax")).select_by(:text, "2")

    @driver.find_element(:id,"search_ride_date").click
    @driver.find_element(:id,'calcurrent').click
 
   Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "search_pickup_time_hour")).select_by(:text, "11 PM")

    @driver.find_element(:id,"search_pickup_place").send_keys "4333 University Way Northeast, Seattle"
    @driver.find_element(:id,"search_drop_off_place").send_keys "SEA"
    @driver.find_element(:id,"search_submit").click
    element_present?(:id, "modify-search").should be_true
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
end
