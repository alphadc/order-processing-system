class Order < ApplicationRecord
  belongs_to :user

  # Scope to fetch all completed buy orders
  scope :completed_buy_orders, -> { where(order_type: 'buy', status: 'completed') }

  # Business Logic Method to process an order
  def process_order
    if order_type == 'buy' && price < buy_threshold
      update(status: 'completed')
    elsif order_type == 'sell' && price > sell_threshold
      update(status: 'completed')
    else
      update(status: 'canceled')
    end
  rescue StandardError => e
    Rails.logger.error("Error processing order #{id}: #{e.message}")
  end

  # Database Query to calculate the total quantity of completed orders for a specific user
  def self.total_completed_quantity_for_user(user_id)
    completed_buy_orders.where(user_id: user_id).sum(:quantity)
  end

  private

  def buy_threshold
    100
  end

  def sell_threshold
    200
  end
end
