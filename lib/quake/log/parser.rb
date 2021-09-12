# frozen_string_literal: true

require_relative 'entities/game'
require_relative 'entities/kill'
require_relative 'entities/shutdown'
require_relative 'entities/player'

module Quake::Log
  class Parser
    attr_reader :games

    def initialize(file, parsers = [])
      @lines = file.readlines
      @parsers = if parsers.empty?
                   [
                     Parsers::Game.new,
                     Parsers::Shutdown.new,
                     Parsers::Kill.new,
                     Parsers::Player.new
                   ]
                 else
                   parsers
                 end
      @games = []
      @players = {}
      @game_running = false
    end

    # Execute all registered parses for every line in the log file.
    def parse!
      # Worst case O(parsers * lines)
      # Best case  O(1 * lines)
      @lines.each do |line|
        @parsers.each do |parser|
          next unless parser.parse?(line)

          delegate_action(entity: parser.parse(line))
          break
        end
      end

      shutdown! if game_running?

      self
    end

    private

    # Is responsible to know what kind of action will be executed when
    # an Entity is match.
    def delegate_action(entity:)
      case entity
      when Entities::Game
        start_game(game: entity)
      when Entities::Kill
        register_kill(kill: entity)
      when Entities::Player
        sign_in(player: entity)
      when Entities::Shutdown
        !shutdown!
      end
    end

    def current_match
      @games.last
    end

    def game_running?
      @game_running
    end

    # It finishes the game that currently is under parsing.
    # This method has TWO responsabilities:
    # 1) Swap players ids by their names in the current game entry
    # 2) Make player's name unique on the player list
    def shutdown!
      return unless game_running?

      current_match[:kills].transform_keys! { |id| @players[id] }
      current_match[:players] = @players.values.uniq
      @game_running = false
    end

    # It pushes a new game to the games list.
    # Also it will finish the current game if we try to start a new one.
    def start_game(game:)
      shutdown! if game_running?

      @games << game.data
      @players = {}
      @game_running = true
    end

    def register_kill(kill:)
      return unless game_running?

      current_match[:total_kills] += 1
      current_match[:kills_by_means][kill.by] += 1

      if kill.by_world?
        current_match[:kills][kill.assassinated_id] -= 1
      elsif !kill.by_itself?
        current_match[:kills][kill.assassin_id] += 1
      end
    end

    def sign_in(player:)
      return unless game_running?

      @players[player.id] = player.nick
    end
  end
end
