require 'spec_helper'

shared_examples "dashboard viewing checker" do
  let(:dashboard_page) { DashboardPage.given }
  it { expect(dashboard_page.title).to eql("Dashboard") }
end

describe "Dashboard viewing" do
  before { login_as_test_user }
  context "via home page" do
    context "via menu" do
      before { HomePage.open.goto_dashboard }
      it_behaves_like "dashboard viewing checker"
    end
    context "via logo" do
      before { HomePage.open.click_logo }
      it_behaves_like "dashboard viewing checker"
    end
  end
  context "by direct url" do
    before { DashboardPage.open }
    it_behaves_like "dashboard viewing checker"
  end
end



