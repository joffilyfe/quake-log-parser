# frozen_string_literal: true

module Quake
  module Log
    module Entities
      class Game
        def data
          { total_kills: 0, players: [], kills: Hash.new(0), kills_by_means: Hash.new(0) }
        end
      end
    end
  end
end
