class DailyRecord < ApplicationRecord
  before_save :calculate_average_age, if: -> { male_count_changed? || female_count_changed? }

  default_scope { order(created_at: :desc) }

  private

  def calculate_average_age
    male_users = User.where(gender: 'male')
    female_users = User.where(gender: 'female')

    self.male_avg_count = male_users.average(:age) if male_users.exists?
    self.female_avg_count = female_users.average(:age) if female_users.exists?
  end
end

