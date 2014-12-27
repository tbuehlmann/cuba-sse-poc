module SSE
  class BroadcastList
    attr_reader :list

    def initialize
      @list = []
      @mutex = Mutex.new
    end
 
    def add(stream)
      @mutex.synchronize do
        @list << stream
      end
    end
 
    def remove(stream)
      @mutex.synchronize do
        @list.delete(stream)
      end
    end
 
    def broadcast(event)
      targets = @mutex.synchronize { @list.dup }

      targets.each do |stream|
        stream.add(event)
      end
    end
  end
end
