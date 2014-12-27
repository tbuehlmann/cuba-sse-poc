require 'cuba'

module SSE
  class Response < Cuba::Response
    attr_writer :body
  end
end
