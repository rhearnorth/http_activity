module Net
  class HTTP
    alias_method(:orig_request, :request) unless method_defined?(:orig_request)

    def request(req, body = nil, &block)
      return orig_request(req, body, &block) unless started?

      url = URI.parse("http://#{@address}:#{@port}#{req.path}")
      if HttpActivity.options[:debug]
        HttpActivity.logger.debug "Net::HTTP#request Url:#{url} Body:#{body}"
      end

      if HttpActivity.ignored_activity?(url.host)
        orig_request(req, body, &block)
      else
        stating_time = Time.now
        @response = orig_request(req, body, &block)
        activity_data = {
          url: url.to_s,
          request_body: body || req.body,
          request_time: stating_time,
          response_body: @response.body,
          response_time: Time.now,
          http_verb: req.method
        }
        HttpActivity.log(activity_data)
        @response
      end
    end
  end
end
