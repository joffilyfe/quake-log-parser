RSpec.describe Quake::Log::Entities::Player do
  subject { Quake::Log::Entities::Player.new({ nick: 'player 1', id: '1' }) }

  describe('#data') do
    it('should has this method') do
      expect(subject.respond_to?(:data)).to be(true)
    end

    it('returns a new game data') do
      expected = { nick: 'player 1', id: '1' }
      expect(subject.data).to eq(expected)
    end
  end

  describe('#nick') do
    it('returns the player nick name') do
      expect(subject.nick).to eq('player 1')
    end
  end

  describe('#id') do
    it('returns the player id') do
      expect(subject.id).to eq(1)
    end
  end
end
