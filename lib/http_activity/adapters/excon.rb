if defined?(Excon)
  module Excon
    class Connection
      alias_method :orig_request, :request

      def request(params, &block)
        datum = @data.merge(params)
        url = _httplog_url(datum)
        puts "HttpActivty::Excon#request #{params}" if HttpActivity.options[:debug]
        if HttpActivity.ignored_activity?(url)
          orig_request(params, &block)
        else
          stating_time = Time.now
          @response = orig_request(params, &block)
          activity_data = {
            url: url,
            request_body: datum[:body],
            request_time: stating_time,
            response_body: @response.body,
            response_time: Time.now,
            http_verb: datum[:method]
          }
          HttpActivity.log(activity_data)
          @response
        end
      end

      def _httplog_url(datum)
        "#{datum[:scheme]}://#{datum[:host]}:#{datum[:port]}#{datum[:path]}#{datum[:query]}"
      end
    end
  end
end
