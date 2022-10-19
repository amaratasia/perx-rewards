# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  after_create :add_reward_points
  
  BASE_CURRENCY = 'INR'
  def add_reward_points
    # TODO: move to model/table based dynamic rule evalutation
    base_amount_su = 100_00
    return unless amount_su >= base_amount_su

    earned_points = amount_su / base_amount_su * 10
    reason = ['Order Greater than 100']
    if(currency != BASE_CURRENCY)
      earned_points = earned_points * 2
      reason << 'foreign currency'
    end
    user.add_points(earned_points, order_id: id, reason: reason.join(', '))
  end
end
