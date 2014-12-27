module SSE
  class Stream
    def initialize
      @queue = Queue.new
    end
 
    def add(event)
      @queue << event
    end
 
    def each
      while event = @queue.pop
        yield event.to_s
      end
    end
 
    def close
      @queue << nil
    end
    
    def empty?
      false
    end
  end
end
