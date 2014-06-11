module HeavyWeightDoubles
  module Double
    def double_reader(method)
      clone_verification_callback = "#{method}_behaves?".to_sym

      define_method(method) do
        send(:halt_bad_clone_detected!) unless send(clone_verification_callback)
        send(:no_need_need_to_verify_move_along)
        @options[method]
      end

      define_method(:halt_bad_clone_detected!) do
        clone_verification_callback = :halt_bad_clone_detected!
        raise "Double cannot be verified"
      end

      define_method(:no_need_need_to_verify_move_along) do
        clone_verification_callback = :no_need_need_to_verify_move_along
      end
    end
  end
end
