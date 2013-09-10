require_relative 'web_page'
require_relative 'course_list_page'
require_relative 'view_course_page'
require_relative 'dashboard_page'


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
    LOGIN_LINK = [:css, '#login-link']
    SESSION_EMAIL = [:css, '#session_email']
    SESSION_PASS = [:css, '#session_password']
    LOGIN_BTN = [:xpath, '//button[normalize-space(text()) = "Login"]']
    GO_TO_COURSE = [:xpath, '//a[normalize-space(text())="Go to course"]']
    DASHBOARD = [:css, '.icon-dashboard']
    LOGO = [:css, '.brand']
  end

  def go_to_courses
    find(*L::GO_TO_COURSES).click
    CourseListPage.given
  end

  def start_login
    find(*L::LOGIN_LINK).click
    self
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

  def fill_session_form(email, password)
    find(*L::SESSION_EMAIL).set(email)
    find(*L::SESSION_PASS).set(password)
    self
  end

  def do_login
    find(*L::LOGIN_BTN).click
    self
  end

  def finish_signup
    find(*L::SIGN_UP_BTN).click
  end

  def popup_opened?
    small_wait_until { return true if first(*L::CLOSE_BTN) }
  end

  def logged_in?
    small_wait_until { return true if first(*L::ICON_USER) }
  end

  def goto_dashboard
    find(*L::DASHBOARD).click
    DashboardPage.given
  end

  def click_logo
    find(*L::LOGO).click
    DashboardPage.given
  end

  def navigate_to_first_course
    first(*L::GO_TO_COURSE).click
    ViewCoursePage.given
  end
end