require 'spec_helper'
describe "Administration_OneWayRideReservation_CanadaZip" do
  it "Administration_OneWayRideReservation_CanadaZip", :js => true do
    visit Capybara.default_host
    find_link('Sign In').click
    fill_in 'email', :with => 'joyce2@limos.com'
    fill_in 'password', :with => 'password'
    find_button('Sign-in').click
    find_link('Manage Customers').click
    fill_in 'email', :with => 'baba@aol.com'
    find('#btn_find').click
    select('Point-to-Point (one-way)', :from => 'service_type')
    fill_in 'time_pickup', :with => '10:15pm'
    #fill_in 'time_dropoff', :with => '12:00pm'
    fill_in 'search_pickup_place', :with => '6083 McKay Ave, Burnaby, BC V5H 2W7, Canada'
    fill_in 'search_drop_off_place', :with => '7060 Kingsway,Burnaby, BC V5E 1E5, Canada'
    select('4', :from => 'search_pax')
    find('#search_ride_date').click
    find('#calcurrent').click
    find_button('See Prices').click
    while (page.has_link?('Select') == false)
      sleep(1)
    end
    first(:link, 'Select').click
    select('Leo Pekker', :from => 'passengers_list')
    page.should have_text('Acct Type:  Business')
    page.should have_text('First name: Leo')
    page.should have_text('Last name: Pekker')
    page.should have_link('Enter Account')
    rideDate = first(:xpath, "//*[@id='edit_reservation_request']/fieldset[2]//h4").text
    find_button('Reserve').click
    while (page.has_css?('.centered.horiz>img') == true)
      sleep(1)
    end
    page.should have_text('Reservation Confirmation')
    page.assert_selector('#self_service_change_button')
    page.assert_selector('#self_service_cancel_button')
    find('#your-trip').text.should == rideDate

  end
  
end
