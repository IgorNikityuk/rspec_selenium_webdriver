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
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
end
