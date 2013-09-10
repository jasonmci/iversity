require "rspec/expectations"

class WebPage

  BLANK_PAGE = 'about:blank'
  IncorrectPageError = Class.new(StandardError)

  include RSpec::Matchers

  def self.open(url="#{app_url}#{self::URL}")
    #puts "Open #{self.name} page by '#{url}' url"
    retryable(tries: 2, trace: true, on: Exception) do |retries|
      #puts "Retry..." unless retries.zero?
      visit url
    end
    new
  end

  def self.given
    new
  end

  def click_alert_box(flag)
    if %w[selenium selenium_dev sauce].include? settings.driver
      if flag
        page.driver.browser.switch_to.alert.accept
      else
        page.driver.browser.switch_to.alert.dismiss
      end
    else
      if flag
        page.evaluate_script('window.confirm = function() { return true; }')
      else
        page.evaluate_script('window.confirm = function() { return false; }')
      end
    end
  end


  # @deprecated
  # With Capybara 2.x it is extra
  def wait_for_ajax(timeout=settings.timeout_small, message=nil)
    end_time = ::Time.now + timeout
    until ::Time.now > end_time
      return true if page.evaluate_script('$.active') == 0
      sleep 0.25
    end
    log.error message || "Timed out waiting for ajax requests to complete"
  end

  def wait_for_url(expected_url, time_out=settings.timeout_small)
    end_time = ::Time.now + time_out
    until ::Time.now > end_time
      operator = expected_url.is_a?(Regexp) ? :=~ : :==
      return true if current_url.send(operator, expected_url).tap{|res| sleep 1 unless res}
    end
    raise IncorrectPageError, "Current url: #{current_url}, expected:  #{expected_url}"
  end

  def reload
    #puts "Reload '#{current_url}'"
    visit current_url
  end

  def self.current_url
    page.current_url
  end

  def self.text
    page.find('body').text
  end

  def self.title
    page.find('title').text
  end

  private
  def small_wait_until
    time_start = Time.now
    while Time.now - time_start < settings.timeout_short
      yield
    end
  end

  def initialize
    wait_for_url(self.class::URL_PATTERN)
  end
end