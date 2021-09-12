# frozen_string_literal: true

module Quake
  module Log
    module Entities
    end

    module Parsers
    end
  end
end

require 'quake/log/entities/game'
require 'quake/log/entities/kill'
require 'quake/log/entities/player'
require 'quake/log/parsers/game'
require 'quake/log/parsers/kill'
require 'quake/log/parsers/player'
require 'quake/log/parsers/shutdown'
