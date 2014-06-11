require 'spec_helper'

module HeavyWeightDoubles
  describe Double do
    it 'should allow specified methods to be called' do
      a_class = Class.new do
        extend Double
        double_reader :foo

        def initialize(options = {})
          @options = options
        end

        def assert_foo; true end
      end

      expect(a_class.new(foo: 'bar').foo).to eq 'bar'
    end

    it 'should call an assertion method when returning the value' do
      a_class = Class.new do
        extend Double
        double_reader :foo
        attr_reader :called

        def initialize(options = {})
          @options = options
          @called = false
        end

        def assert_foo
          @called = true
        end
      end

      an_instance = a_class.new(foo: 'bar')
      expect(an_instance.called).to eq false
      an_instance.foo
      expect(an_instance.called).to eq true
    end

    it 'should raise an error if the assertion method return false' do
      a_class = Class.new do
        extend Double
        double_reader :foo

        def initialize(options = {})
          @options = options
        end

        def assert_foo
          false
        end
      end

      expect{a_class.new(foo: 'bar').foo}.to raise_error
    end

    it 'should only call the assertion one time on error' do
      a_class = Class.new do
        extend Double
        double_reader :foo
        attr_reader :called

        def initialize(options = {})
          @options = options
          @called = 0
        end

        def assert_foo
          @called += 1
          false
        end
      end

      an_instance = a_class.new(foo: 'bar')
      expect{an_instance.foo}.to raise_error
      expect{an_instance.foo}.to raise_error
      expect(an_instance.called).to eq 1
    end

    it 'should only call the assertion one time when valid' do
      a_class = Class.new do
        extend Double
        double_reader :foo
        attr_reader :called

        def initialize(options = {})
          @options = options
          @called = 0
        end

        def assert_foo
          @called += 1
          true
        end
      end

      an_instance = a_class.new(foo: 'bar')
      an_instance.foo
      an_instance.foo
      expect(an_instance.called).to eq 1
    end
  end
end
