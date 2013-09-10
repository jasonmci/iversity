require 'spec_helper'

shared_examples "catalog viewing checker" do
  it { expect(course_list_page.title).to eql("All Courses") }
  it { expect(course_list_page).to be_course_list_present }
end

describe "Catalog viewing" do
  context "via home page" do
    let(:course_list_page) { CourseListPage.given }
    before { HomePage.open.go_to_courses }
    it_behaves_like "catalog viewing checker"
  end
  context "by direct url" do
    let(:course_list_page) { CourseListPage.given }
    before { CourseListPage.open }
    it_behaves_like "catalog viewing checker"
  end
end