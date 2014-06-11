module HeavyWeightDoubles
  module Double
    def double_reader(method)
      assertion_callback_method = "assert_#{method}".to_sym

        define_method(method) do
          send(:mock_not_correct) unless send(assertion_callback_method)
          send(:mock_correct)
          @options[method]
        end

        define_method(:mock_not_correct) do
          assertion_callback_method = :mock_not_correct
          raise "Mock does not meet assertion"
        end

        define_method(:mock_correct) do
          assertion_callback_method = :mock_correct
        end
    end
  end
end
