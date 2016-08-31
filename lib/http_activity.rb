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
      Thread.current["HttpActivity"] ||= DEFAULT_OPTIONS.clone
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
      if options[:debug]
        logger.debug "ACTIVITY DATA: #{activity_data}"
      end
      activity_data.merge!(options[:additional_data]) unless options[:additional_data].nil?
      RestClient.post(options[:log_destination], activity_data.to_json)
    rescue Exception => e
      logger.error e
    end

    attr_writer :logger
    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.progname = self.name
      end
    end
  end
end
