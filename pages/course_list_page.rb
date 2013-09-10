require_relative 'web_page'

class CourseListPage < WebPage
  URL = '/courses'
  URL_PATTERN = /courses\/?\z/

  module L
    GO_TO_COURSES = [:xpath, '//*[normalize-space(text())= "Go to courses"]']
    COURSE_LIST = [:css, '.courses-list']
  end

  def course_list_present?
    find(*L::COURSE_LIST).visible?
  end

end