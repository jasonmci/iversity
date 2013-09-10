
require_relative 'web_page'

class ViewCoursePage < WebPage
  URL = '/'
  URL_PATTERN = /courses\/.+/

  module L
    ENROLL = [:xpath, '//*[contains(@class, "course-card")]//*[normalize-space(text()) = "Enrol"]']
    UNENROLL = [:xpath, '//*[contains(@class, "course-card")]//a[text()="Unenrol"]']
    PREVIEW_COURSE = [:xpath, "//button[normalize-space(.)='Preview Course']"]
  end

  def enroll
    find(*L::ENROLL).click
  end

  def unenroll
    find(*L::UNENROLL).click
    self
  end

  def unenrol_if_possible
    url = current_url
    if enrolled?
      unenroll
      visit url
    end
    self
  end

  def enrolled?
    small_wait_until{ return true if first(*L::UNENROLL) }
  end
end