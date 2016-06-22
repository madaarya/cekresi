require "cekresi/version"
require 'cekresi/user_agent'
require 'cekresi/cekresi_parser'
require 'capybara'
require 'capybara/poltergeist'

Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.run_server = false
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,{:js_errors => false,:timeout => 1000,:debug => false,:inspector => false})
end

module Cekresi

  def self.fetch(tracking_number)
    url = "http://cekresi.com/?noresi=#{tracking_number}"
    session = Capybara::Session.new(:poltergeist)
    session.driver.headers = {'User-Agent' => USER_AGENTS.sample}
    session.visit(url)
    session.find("#cekresi").click
    begin
      container_result = session.find(:xpath, "//div[@id='results']")
      if container_result
        if container_result.find(".top_title")
          result = Cekresi::Parser.parse(container_result)
        else
          result = {status: :not_found, message: container_result.text}
        end
      else
        result = {status: :not_found, message: 'Sorry your search not found'}
      end
    rescue Capybara::ElementNotFound
      result = {status: :not_found, message: 'There is problem from cekresi.com, please try again'}
    end

    Capybara.reset_sessions!
    session.driver.quit
    return result
  end

end