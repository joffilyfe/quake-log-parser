require 'stringio'

RSpec.describe Quake::Log::Parser do
  let (:parsers) do
    [
      Quake::Log::Parsers::Game.new,
      Quake::Log::Parsers::Kill.new,
      Quake::Log::Parsers::Player.new,
      Quake::Log::Parsers::Shutdown.new
    ]
  end

  context('When the game log has no lines') do
    subject do
      Quake::Log::Parser.new(
        fixture('game_without_lines.log'),
        parsers
      )
    end

    describe('#parse!') do
      it('returns self with empty matches array') do
        expect(subject.parse!.games).to eq([])
      end
    end
  end

  context('When the game log has no activity') do
    subject do
      Quake::Log::Parser.new(
        fixture('game_without_kills.log'),
        parsers
      )
    end

    describe('#parse!') do
      it('returns self with a empty game sample data') do
        expected = [
          { :kills => {}, :kills_by_means => {}, :players => ["Isgalamido"], :total_kills => 0 }
        ]
        expect(subject.parse!.games).to eq(expected)
      end
    end
  end

  context('When the game log has players and deaths') do
    subject do
      Quake::Log::Parser.new(
        fixture('game_with_11_deaths.log'),
        parsers
      )
    end

    describe('#parse!') do
      it('returns self with a not empty match list') do
        expect(subject.parse!.games.empty?).to eq(false)
      end
    end

    context('matches') do
      before do
        subject.parse!
      end

      it('has one match') do
        expect(subject.games.size).to eq(1)
      end

      it('returns self with one match') do
        expect(subject.games.size).to eq(1)
      end

      context('current') do
        it('has 11 kills') do
          expect(subject.games.first[:total_kills]).to eq(11)
        end

        it('has two player') do
          expect(subject.games.first[:players].size).to eq(2)
          expect(subject.games.first[:players]).to eq(["Isgalamido", "Mocinha"])
        end
      end
    end
  end

  context('When the game log has players with more deaths than kills') do
    subject do
      Quake::Log::Parser.new(
        fixture('game_player_with_more_deaths_than_kills.log'),
        parsers
      )
    end

    describe('#parse!') do
      it('returns self with a not empty match list') do
        expect(subject.parse!.games.empty?).to eq(false)
      end
    end

    context('Using matches') do
      before do
        subject.parse!
      end

      context('To check players kills') do
        it('Isgalamido has -2 kills') do
          expect(subject.games.first[:kills]["Isgalamido"]).to eq(-2)
        end

        it('Joffily has 0 kills') do
          expect(subject.games.first[:kills]["Joffily"]).to eq(0)
        end
      end
    end
  end

  context('When the game log has a player that changed its nick name') do
    subject do
      Quake::Log::Parser.new(fixture('game_with_player_changing_nick.log'))
    end

    before do
      subject.parse!
    end

    it('player list should contains only one nick') do
      expect(subject.games.last[:players].size).to be(1)
    end

    it('player nick should be the last changed by player') do
      expect(subject.games.last[:players]).to eq(['Third name'])
    end
  end

  context('When the game log has not the shutdown event') do
    subject do
      Quake::Log::Parser.new(fixture('two_game_without_shutdow.log'))
    end

    before do
      subject.parse!
    end

    it('The player list should be populated') do
      expect(subject.games.first[:players].size).to be(2)
    end

    it('The kill score should be populated with player names') do
      expect(subject.games.first[:kills]).to eq({ "Isgalamido" => -7 })
      expect(subject.games.last[:kills]).to eq({ "Isgalamido" => -2 })
    end
  end
end
