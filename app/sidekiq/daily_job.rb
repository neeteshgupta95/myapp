class DailyJob
  include Sidekiq::Job

  def perform(*args)
    puts "End-of-day job running at #{Time.now}"

    payload = {
      date: Date.today,
      male_count: GenderCountService.get_male_count,
      female_count: GenderCountService.get_female_count
    }

    DailyRecord.create(payload)

    GenderCountService.reset_count

    puts "Job runs successfully"
  end
end
