# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :name, presence: true
  validates :format, presence: true
  validates :format, inclusion: { in: %w[coffee movie rebate],
                                  message: '%<value>s is not a valid format' }, allow_nil: true
  has_many :user_rewards
end
