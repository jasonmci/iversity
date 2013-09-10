module BusinessActions
  def login_as_test_user
    HomePage.open.start_login.fill_session_form(settings.def_test_user, settings.def_test_pass).do_login
    expect(HomePage.given).to be_logged_in
  end
end