if defined?(::HTTPClient)
  class HTTPClient
    private
    alias_method :orig_do_get_block, :do_get_block

    def do_get_block(req, proxy, conn, &block)
      url = req.header.request_uri
      if HttpActivity.options[:debug]
        puts "HttpActivty::HTTPClient#do_get_block Url:#{url} Proxy:#{proxy} Conn:#{conn}"
      end
      if HttpActivity.ignored_activity?(url)
        orig_do_get_block(req, proxy, conn, &block)
      else
        stating_time = Time.now
        @response = orig_do_get_block(req, proxy, conn, &block)
        activity_data = {
          url: url,
          request_body: req.body,
          request_time: stating_time,
          response_body: @response.body,
          response_time: Time.now,
          http_verb: req.header.request_method
        }
        HttpActivity.log(activity_data)
        @response
      end
    end
  end
end
