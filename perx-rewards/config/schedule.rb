# frozen_string_literal: true

every 1.day, at: '12:30 am' do
  rake 'reward:birthday'
end
every 1.day, at: '12:30 am' do
  rake 'reward:new_user'
end

every '0 0 1 * *' do
  rake 'reward:monthly_100_user'
end
every '0 0 1 */3 *' do
  rake 'reward:more_than_2000_order'
end
