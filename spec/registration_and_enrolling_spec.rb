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
  let(:home_page) { HomePage.given }
  let(:view_course_page) { ViewCoursePage.given }
  before do
    login_as_test_user
    home_page.navigate_to_first_course
    view_course_page.unenrol_if_possible.enroll
  end

  it { expect(view_course_page.text).to include('Congratulations!')}
end


