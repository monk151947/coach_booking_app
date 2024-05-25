class User < ApplicationRecord
   has_many :availabilities

    def parse_time_zone
        time_zone.gsub(/\(GMT.*?\)\s/, '')
    end
end
