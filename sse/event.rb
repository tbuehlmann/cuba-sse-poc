module SSE
  class Event
    KEYS = [:event, :data, :id, :retry].freeze

    attr_reader *KEYS

    def initialize(event: nil, data: nil, id: nil, retry_count: nil)
      @event = event
      @data = data
      @id = id
      @retry = retry_count
    end

    def to_s
      KEYS.map do |key|
        if value = public_send(key)
          '%s: %s' % [key, value]
        end
      end.compact.join("\n") + "\n\n"
    end
  end
end
