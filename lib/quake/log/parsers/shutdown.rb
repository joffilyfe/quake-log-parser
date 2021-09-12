# frozen_string_literal: true

require 'quake/log/entities/shutdown'

module Quake
  module Log
    module Parsers
      class Shutdown
        def parse?(line)
          line.strip.match?(/\d{1,2}:\d{1,2} ShutdownGame:*/)
        end

        def parse(*)
          Entities::Shutdown.new
        end
      end
    end
  end
end
