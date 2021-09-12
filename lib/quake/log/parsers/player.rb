# frozen_string_literal: true

require 'quake/log/entities/player'

module Quake
  module Log
    module Parsers
      class Player
        def initialize
          super
          @regex = /\d{1,2}:\d{1,2} ClientUserinfoChanged: (?<id>[\d+]) n\\(?<nick>[\w\s]+).*/
        end

        def parse?(line)
          line.strip.match?(@regex)
        end

        def parse(line)
          Entities::Player.new(line.match(@regex))
        end
      end
    end
  end
end
