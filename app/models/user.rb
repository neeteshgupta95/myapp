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

  def to_liquid
    {
      'id' => id,
      'full_name' => full_name,
      'age' => age,
      'gender' => gender.capitalize,
      'created_at' => created_at.httpdate
    }
  end

  private

  def update_daily_record_count
    daily_record = DailyRecord.first

    if daily_record
      if gender == 'male'
        daily_record.decrement!(:male_count)
      elsif gender == 'female'
        daily_record.decrement!(:female_count)
      end
    end
  end
end
