# frozen_string_literal: true

class User < ApplicationRecord
  validates :dob, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  has_many :orders
  has_many :user_points
  has_many :user_rewards

  def add_points(points, order_id:, reason:)
    transaction do
      self.points += points
      user_points.create(order_id: order_id, meta: { reason: reason }, points: points)
    end
  end

  def tier
    # Cycle is considered last 30 days
    current_points = user_points.where(created_at: (Time.now - 60.days)..(Time.now))
                                .max { |user_point| user_point.current_total }.current_total

    return 'platinum' if current_points > 5000

    return 'gold' if current_points > 1000

    'standard'
  end
end
