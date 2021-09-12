# frozen_string_literal: true

require 'quake/log/entities/kill'

module Quake
  module Log
    module Parsers
      class Kill
        def initialize
          regex = '\d{1,2}:\d{1,2} Kill: (?<assassin_id>\d+) ' \
                  '(?<assassinated_id>\d+) \d+: ' \
                  '(?<assassin>[\<\>\w\s]+) killed ' \
                  '(?<assassinated>[\w\s]+) by ' \
                  '(?<by>[\w\s]+)'
          @regex = /#{regex}/
        end

        def parse?(line)
          line.strip.match?(@regex)
        end

        def parse(line)
          Entities::Kill.new(line.match(@regex))
        end
      end
    end
  end
end
