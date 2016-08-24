require 'http_activity/version'
require 'net/http'
require 'http_activity/adapters/net_http'
require 'http_activity/adapters/excon'
require 'http_activity/adapters/patron'
require 'http_activity/adapters/httpclient'
require 'rest-client'

module HttpActivity
  DEFAULT_OPTIONS = {
    log_destination: '',
    url_blacklist_regex: nil,
    additional_data: {},
    debug: false
  }

  class << self
    def options
      @@options ||= DEFAULT_OPTIONS.clone
    end

    def additional_data(data={})
      options[:additional_data] = data
    end

    def ignored_activity?(url)
      return true if options[:log_destination].match(url)
      return unless options[:url_blacklist_regex]
      url.to_s.match(options[:url_blacklist_regex])
    end

    def log(activity_data)
      puts "ACTIVITY DATA: #{activity_data}" if options[:debug]
      activity_data.merge!(options[:additional_data]) unless options[:additional_data].nil?
      RestClient.post(options[:log_destination], activity_data.to_json)
    rescue Exception => e
      puts "Error: #{e}"
    end
  end
end
