# frozen_string_literal: true

namespace :reward do
  desc 'Rewards'
  task birthday: :environment do
    reward = Reward.find_by(format: 'coffee')
    raise 'Birthday Coffee Reward Not Available' unless reward

    User.where("date(dob) = date('#{Time.now}')").find_each do |user|
      user.user_rewards.create(reward: reward)
    end
  end

  task monthly_100_user: :environment do
    reward = Reward.find_by(format: 'coffee')
    raise 'Coffee Reward Not Available' unless reward

    last_month_date = Time.now - 1.day

    user_ids = UserPoint.where(created_at: last_month_date.beginning_of_month..(last_month_date.end_of_month))
                        .group(:user_id).having('sum(points) > 100').pluck(:user_id)

    User.where(id: user_ids).find_each do |user|
      user.user_rewards.create(reward: reward)
    end
  end

  task new_user: :environment do
    reward = Reward.find_by(format: 'movie')
    raise 'Movie Reward Not Available' unless reward

    start_date = Time.now - 60.days

    user_ids = User.joins(:orders).where('orders.amount_su > (1000 * 100) ')
                   .where("date(users.created_at) = date('#{start_date}')")
                   .pluck('orders.user_id')

    User.where(id: user_ids).find_each do |user|
      user.user_rewards.create(reward: reward)
    end
  end
  task cash_rebate: :environment do
    reward = Reward.find_by(format: 'rebate')
    raise 'Rebate Reward Not Available' unless reward

    user_total_map = {}
    Order.where('amount_su >= (100 * 100)').group(:user_id).having('count(1) >= 10')
         .select('user_id , sum(amount_su) total').each do |data|
      user_total_map[data.user_id] = data.total
      User.where(id: user_total_map.keys).find_each do |user|
        if user_total_map[user.id].present?

          rebate_amount = user_total_map[user.id] * (reward.config['percentage'] / 100)
          user.user_rewards.create(reward: reward, meta: { amount_su: rebate_amount.round })
        end
      end
    end
  end

  task more_than_2000_order: :environment do
    reference_time = Time.now - 1.day
    user_ids = Order.where(created_at: reference_time.beginning_of_quarter..reference_time.end_of_quarter)
                    .group(:user_id)
                    .having('sum(amount_su) > (0 * 100)')
                    .pluck(:user_id)

    User.where(id: user_ids).find_each do |user|
      order = Order.create(user_id: user.id, meta: { reference_id: 'quarterly', type: :points })
      user.add_points(100, order_id: order.id, reason: 'Quarterly Spent more than 2000 ')
    end
  end
end
