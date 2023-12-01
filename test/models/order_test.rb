require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "process_order method sets status correctly for buy orders" do
    order = Order.new(order_type: 'buy', price: 90, quantity: 10, status: 'pending')
    order.process_order

    assert_equal 'completed', order.status
  end

  test "process_order method sets status correctly for sell orders" do
    order = Order.new(order_type: 'sell', price: 210, quantity: 10, status: 'pending')
    order.process_order

    assert_equal 'completed', order.status
  end

  test "process_order method sets status to canceled when conditions are not met" do
    order = Order.new(order_type: 'buy', price: 110, quantity: 10, status: 'pending')
    order.process_order

    assert_equal 'canceled', order.status
  end

end
