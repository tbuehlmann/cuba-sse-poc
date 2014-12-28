require 'cuba'

require 'sse/broadcast_list'
require 'sse/event'
require 'sse/response'
require 'sse/stream'

module SSE
  class Application < Cuba
    settings[:res] = Response
    settings[:broadcast_list] = BroadcastList.new

    define do
      on root do
        res.write File.read(File.join(__dir__, 'views', 'index.html'))
      end

      on 'sse', accept('text/event-stream') do
        stream = Stream.new
        settings[:broadcast_list].add(stream)
        res.headers['Content-Type'] = 'text/event-stream'
        res.body = Rack::BodyProxy.new(stream) { settings[:broadcast_list].remove(stream) }
      end

      on post, 'messages', param('message') do |message|
        escaped_message = Rack::Utils.escape_html(message)
        event = SSE::Event.new(event: 'chat', data: escaped_message)
        settings[:broadcast_list].broadcast(event)
        res.status = 200
      end
    end
  end
end
