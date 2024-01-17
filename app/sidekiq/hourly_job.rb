class HourlyJob
  include Sidekiq::Job

  def perform(*args)
    puts "Hourly job is running at #{Time.now}"

    records = ApiService.new.call(20)['results']

    if records.present?
      users = []
      male_count, female_count = [0, 0]

      records.each do |item|
        user = User.find_or_initialize_by(uuid: item['login']['uuid'])
        payload = { gender: item['gender'],
                    name: item['name'],
                    location: item['location'],
                    age: item['dob']['age'] }

        if user.new_record?
          user.attributes = payload
        else
          user.assign_attributes(payload)
        end

        users << user

        if item['gender'] == 'female'
          female_count = female_count.next
        else
          male_count = male_count.next
        end
      end

      # Bulk insert the records
      puts User.import(users, on_duplicate_key_update: [:uuid])

      GenderCountService.set_male_count(GenderCountService.get_male_count + male_count)
      GenderCountService.set_female_count(GenderCountService.get_female_count + female_count)

      puts "Job runs successfully"
    end
  end
end


