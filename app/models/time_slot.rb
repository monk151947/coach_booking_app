class TimeSlot < ApplicationRecord
  belongs_to :availability

  using Refinements
  DURATION_IN_MINUTES = 30

  def generate_time_slots(start_time:, finish_time:)
    start_time.remove_all_spaces! 
    finish_time.remove_all_spaces! 
    validate_duration_in_minutes
    validate_times(start_time, finish_time)
    compile_and_return_time_slots(Time.parse(start_time),  Time.parse(finish_time))
  end

  class << self
    # N + 1 fix
    def all_with_availabilities(ids)
      includes(:availability).where('availability_id IN (?)', ids).references(:availability)
    end
  end

  private

  def validate_duration_in_minutes
    error_message = "DURATION_IN_MINUTES '#{DURATION_IN_MINUTES}' failed validation."
    raise ArgumentError, error_message unless [15, 30, 60].include? DURATION_IN_MINUTES
  end

  def validate_times(*times)
    times.each do |time|
      raise(ArgumentError, "Time '#{time}' failed validation.") unless regex_match_by_time_format(time)
    end
  end

  def regex_match_by_time_format(time)
    time.match(/^[0-9]{1,2}\:[0-9]{2}?[AP][M]/i)
  end

  def compile_and_return_time_slots(start_time, end_time)
    slots = []
    current_time = start_time
    while current_time < end_time
      interval_end = current_time + 30 * 60
      slots << current_time
      current_time = interval_end
    end
    slots.map{|i| i.strftime('%I:%M%p')}
  end
end
