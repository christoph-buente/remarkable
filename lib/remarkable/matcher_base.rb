module Remarkable # :nodoc:
  module Matcher # :nodoc:
    class Base
      def negative
        @negative = true
        self
      end

      def failure_message
        "Expected #{expectation} (#{@missing})"
      end

      def negative_failure_message
        "Did not expect #{expectation}"
      end

      private

      def model_class
        @subject
      end

      def positive?
        @negative ? false : true
      end

      def negative?
        @negative ? true : false
      end

      def assert_matcher(&block)
        if positive?
          return false unless yield
        else
          return true if yield
        end
        positive?
      end

      def assert_matcher_for(collection, &block)
        collection.each do |item|
          if positive?
            return false unless yield(item)
          else
            return true if yield(item)
          end
        end
        positive?
      end

      def remove_parenthesis(text)
        /#{text.gsub(/\s?\(.*\)$/, '')}/
      end
    end
  end
end
