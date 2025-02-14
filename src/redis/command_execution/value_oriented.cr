class Redis
  # This module contains mixins for the execution of Redis commands.

  # :nodoc:
  module CommandExecution
    # Command execution methods that return real values, not futures.

    # :nodoc:
    module ValueOriented
      # Executes a Redis command and casts it to the correct type.
      # This is an internal method.
      def integer_command(request : Request) : Int64
        command(request).as(Int64)
        rescue ex : TypeCastError
          File.open("/tmp/crash.log", "a") { |f| f.puts("#{Time.local} - #{ex.message.inspect} - #{ex.backtrace.inspect}") }
          raise ex
      end

      # Executes a Redis command and casts it to the correct type.
      # This is an internal method.
      def integer_or_nil_command(request : Request) : Int64?
        command(request).as(Int64?)
      end

      # Executes a Redis command and casts it to the correct type.
      # This is an internal method.
      def integer_or_string_command(request : Request) : Int64 | String
        res = command(request)
        res.is_a?(String) ? res.as(String) : res.as(Int64)
      end

      # Executes a Redis command and casts it to the correct type.
      # This is an internal method.
      def integer_array_command(request : Request) : Array(RedisValue)
        command(request).as(Array(RedisValue))
      end

      # Executes a Redis command and casts it to the correct type.
      # This is an internal method.
      def string_command(request : Request) : String
        command(request).as(String)
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def string_or_nil_command(request : Request) : String?
        res = command(request)
        res = nil if res.is_a?(Array) && res.empty? # "*-1\r\n"
        res.as(String?)
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def string_array_command(request : Request) : Array(RedisValue)
        command(request).as(Array(RedisValue))
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def string_array_or_integer_command(request : Request) : Array(RedisValue) | Int64
        command(request).as(Array(RedisValue) | Int64)
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def string_array_or_string_or_integer_command(request : Request) : Array(RedisValue) | String | Int64
        command(request).as(Array(RedisValue) | String | Int64)
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def string_array_or_string_command(request : Request) : Array(RedisValue) | String
        command(request).as(Array(RedisValue) | String)
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def string_array_or_string_or_nil_command(request : Request) : Array(RedisValue) | String?
        command(request).as(Array(RedisValue) | String?)
      end

      # Executes a Redis command and casts the response to the correct type.
      # This is an internal method.
      def array_or_nil_command(request : Request) : Array(RedisValue)?
        command(request).as(Array(RedisValue)?)
      end

      # Executes a Redis command that has no relevant response.
      # This is an internal method.
      def void_command(request : Request) : Nil
        command(request).as(Nil)
      end
    end
  end
end
