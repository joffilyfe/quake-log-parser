# frozen_string_literal: true

module Quake
  module Log
    module Entities
      class Player
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def nick
          @data[:nick].strip
        end

        def id
          @data[:id].strip.to_i
        end
      end
    end
  end
end
