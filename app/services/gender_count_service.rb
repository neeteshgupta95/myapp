class GenderCountService
  class << self
    def set_male_count(count)
      $redis.set('male_count', count)
    end

    def set_female_count(count)
      $redis.set('female_count', count)
    end

    def get_male_count
      $redis.get('male_count').to_i
    end

    def get_female_count
      $redis.get('female_count').to_i
    end
  end
end
