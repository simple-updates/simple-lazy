require "minitest/autorun"
require_relative "../../lib/simple/lazy"

class TestSimpleLazy < Minitest::Test
  def test_1
    assert_equal(1, Simple::Lazy.new(1) { }.value)
    assert_equal(false, Simple::Lazy.new(1) { }.cached?)
  end

  def test_2
    user = Simple::Lazy.new(1) { |id| Struct.new(:name).new("a#{id}") }

    assert_equal(1, user.value)
    assert_equal(false, user.cached?)
    assert_equal("a1", user.name)
    assert_equal(true, user.cached?)
  end

  def test_3
    error = nil

    begin
      lazy = Simple::Lazy.new(1) { |id| raise 'oops' }
      lazy.inspect
      lazy.value
      lazy.cached?
      [lazy, lazy, (lazy == lazy) && 1, lazy.eql?(lazy) && 1].sort
      lazy.hash
    rescue => e
      error = e
      puts error.backtrace
    end

    assert_nil(error)
  end

  def test_4
    lazy = Simple::Lazy.new(1) { |id| "oh" }
    assert_equal("oh", lazy.to_s)
  end

  def test_5
    lazy = Simple::Lazy.new(1) { nil }
    assert_equal(false, lazy.cached?)
    assert_equal("", lazy.to_s)
    assert_equal(true, lazy.cached?)
  end

  def test_6
    lazy = Simple::Lazy.new(1) { 2 }
    assert_equal(true, lazy.respond_to?(:to_i))
    assert_equal(false, lazy.respond_to?(:to_something_else))
  end
end
