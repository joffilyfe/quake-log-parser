# frozen_string_literal: true

require 'quake/log/entities/game'

module Quake
  module Log
    module Parsers
      class Game
        def parse?(line)
          line.strip.match?(/\d{1,2}:\d{1,2} InitGame.*/)
        end

        def parse(*)
          Quake::Log::Entities::Game.new
        end
      end
    end
  end
end
