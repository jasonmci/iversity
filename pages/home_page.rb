require_relative 'web_page'
require_relative 'course_list_page'

class HomePage < WebPage
  URL = '/'
  URL_PATTERN = /#{Regexp.escape(settings.app_host)}\/?/

  module L
    GO_TO_COURSES = [:xpath, '//*[normalize-space(text()) = "Go to courses"]']
    SIGN_UP_LINK = [:css, '.signup-link']
    SIGN_UP_BTN = [:xpath, '//button[normalize-space(text()) = "Sign up"]']
    FIRST_NAME = [:css, '#user_first_name']
    LAST_NAME = [:css, '#user_last_name']
    EMAIL = [:css, '#user_email']
    PASSWORD = [:css, '#user_password']
    CLOSE_BTN = [:css, '.modal-header .close']
    ICON_USER = [:css, '.icon-user']
  end

  def go_to_courses
    find(*L::GO_TO_COURSES).click
    CourseListPage.given
  end

  def start_signup
    find(*L::SIGN_UP_LINK).click
    self
  end

  def fill_signup_form(first_name=nil, last_name=nil, email=nil, password=nil)
    find(*L::FIRST_NAME).set(first_name) if first_name
    find(*L::LAST_NAME).set(last_name) if last_name
    find(*L::EMAIL).set(email) if email
    find(*L::PASSWORD).set(password) if password
    self
  end

  def finish_signup
    find(*L::SIGN_UP_BTN).click
    self
  end

  def logged_in?
    time_start = Time.now
    while Time.now - time_start < 3
      return true if first(*L::ICON_USER)
    end
  end

end