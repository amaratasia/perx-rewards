class UserPoint < ApplicationRecord
  belongs_to :order
  belongs_to :user

  before_create do
    self.running_balance = self.class.where(user_id: user_id).sum(:points)
  end

  after_create do 
    self.user.points += self.points
    self.user.save
  end

  def current_total
    running_balance + points
  end
end
