# frozen_string_literal: true
require 'csv'

class Importer
  class << self
    def from_csv(path)
      counter = 0
      CSV.foreach(path, headers: true, return_headers: false,
                        header_converters: :symbol, converters: :all) do |row|
        ActiveRecord::Base.transaction do
          # No duplicate coaches shall be added!
          coach = Coach.create_with(time_zone: row[:timezone]).find_or_create_by!(name: row[:name])

          # Translate the String into an Integer based upon the index value
          day_of_week = Availability::DAYS_OF_WEEK.index(row[:day_of_week])

          # Housekeeping
          start_time = row[:available_at].strip
          finish_time = row[:available_until].strip

          # Create all coach availabilities
          availability = coach.availabilities.create!(day_of_week: day_of_week,
                                                      start: start_time, end: finish_time)

          # Array of generated times
          slots_array = TimeSlot.new.generate_time_slots(start_time: start_time, finish_time: finish_time)

          # Create all slots in DB
          slots_array.map { |slot_time| TimeSlot.create!(availability: availability, start: slot_time) }

          counter += 1
        end
      end

      counter
    end
  end
end