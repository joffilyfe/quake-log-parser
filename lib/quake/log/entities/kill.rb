# frozen_string_literal: true

module Quake
  module Log
    module Entities
      class Kill
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def by_player?
          @data[:assassin] != '<world>'
        end

        def by_world?
          @data[:assassin] == '<world>'
        end

        def assassin_id
          @data[:assassin_id].strip.to_i
        end

        def assassinated_id
          data[:assassinated_id].strip.to_i
        end

        def assassin
          data[:assassin].strip
        end

        def assassinated
          data[:assassinated].strip
        end

        def by
          data[:by].strip
        end

        def by_itself?
          assassin_id == assassinated_id
        end
      end
    end
  end
end
