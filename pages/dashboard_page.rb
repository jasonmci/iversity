require_relative 'web_page'

class DashboardPage < WebPage
  URL = '/dashboard'
  URL_PATTERN = /dashboard\/?\z/

  module L
  end
end