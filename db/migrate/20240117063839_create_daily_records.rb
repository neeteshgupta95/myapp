class CreateDailyRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_records do |t|
      t.date :date
      t.integer :male_count
      t.integer :female_count
      t.integer :male_avg_count
      t.integer :female_avg_count

      t.timestamps
    end
  end
end
