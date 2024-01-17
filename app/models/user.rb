class User < ApplicationRecord
  before_destroy :update_daily_record_count

  default_scope { order(created_at: :desc) }
  scope :search_by_name, ->(query) { where("name->>'first' ILIKE :query OR name->>'last' ILIKE :query", query: "%#{query}%") if query.present? }

  def title
    name ? "#{name['title']}" : ''
  end

  def full_name
    name ? "#{name['first']} #{name['last']}" : ''
  end

  private

  def update_daily_record_count
    daily_record = DailyRecord.last

    if daily_record
      if gender == 'male'
        daily_record.male_count -= 1
      elsif gender == 'female'
        daily_record.female_count -= 1
      end

      daily_record.save
    end
  end
end
