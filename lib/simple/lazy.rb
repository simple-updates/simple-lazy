module Simple
  class Lazy
    VERSION = "1.0.2"

    attr_reader :value

    def initialize(value, &block)
      @block = block
      @value = value
      @cached = nil
      @is_cached = false
    end

    def hash
      value.hash
    end

    def eql?(other)
      other.is_a?(Simple::Lazy) ? value == other.value : value == other
    end

    def <=>(other)
      other.is_a?(Simple::Lazy) ? value <=> other.value : value <=> other
    end

    def method_missing(method, *args, &block)
      cached.public_send(method, *args, &block)
    end

    def respond_to_missing?(method, include_private = false)
      cached.respond_to?(method) || super
    end

    def methods
      methods + cached.methods
    end

    def cached
      unless @is_cached
        @cached = @block.call(value)
        @is_cached = true
      end

      @cached
    end

    def cached?
      @is_cached
    end

    def to_s
      cached.to_s
    end

    def inspect
      "#<Simple::Lazy @value=#{@value.inspect} cached?=#{cached?.inspect}>"
    end
  end
end
