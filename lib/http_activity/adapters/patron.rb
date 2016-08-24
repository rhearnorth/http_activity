if defined?(Patron)
  module Patron
    class Session
      alias_method :orig_request, :request
      def request(action_name, url, headers, options = {})
        if HttpActivity.options[:debug]
          puts "HttpActivty::Patron#request Action:#{action_name} Url:#{url} Headers:#{headers} Options:#{options}"
        end
        if HttpActivity.ignored_activity?(url)
          orig_request(action_name, url, headers, options)
        else
          stating_time = Time.now
          @response = orig_request(action_name, url, headers, options)
          activity_data = {
            url: url,
            request_body: options[:data],
            request_time: stating_time,
            response_body: @response.body,
            response_time: Time.now,
            http_verb: action_name
          }
          HttpActivity.log(activity_data)
          @response
        end
      end
    end
  end
end
