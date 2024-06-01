# rubocop:disable Style/Documentation
# frozen_string_literal: true

class Student < User
  using Refinements
  validates :name, presence: true

  def to_coaches_time_zone(time:, student:, coach:)
    # Parse the input time string into a Time object
    from_time = Time.parse(time)
    # Get the source and target timezones
    from_zone = ActiveSupport::TimeZone.find_tzinfo(student.parse_time_zone)
    to_zone = ActiveSupport::TimeZone.find_tzinfo(coach.parse_time_zone)
    # Convert the time from the source timezone to UTC
    utc_time = from_zone.local_to_utc(from_time)
    # Convert the UTC time to the target timezone
    converted_time = to_zone.utc_to_local(utc_time)

    converted_time
  end
end
