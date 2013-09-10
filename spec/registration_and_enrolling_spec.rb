require 'spec_helper'

describe "Registration" do
  let(:home_page) { HomePage.given }
  before { HomePage.open.start_signup }

  context "via user/pass" do
    before do
      home_page.fill_signup_form(
        "TestFirstName",
        "TestLastName",
        "test#{serial}@test.com",
        "Test1234"
      ).finish_signup
    end
    it { expect(home_page).to be_logged_in }
  end
  context "via Facebook" #nothing special, just need more time
end

describe "Course enrolling" do

end


