RSpec.describe Quake::Log::Entities::Game do
  subject { Quake::Log::Entities::Game.new }

  describe('#data') do
    it('should has this method') do
      expect(subject.respond_to?(:data)).to be(true)
    end

    it('returns an empty game data') do
      expected = {
        'total_kills': 0,
        'players': [],
        'kills': {},
        'kills_by_means': {}
      }
      expect(subject.data).to eq(expected)
    end
  end
end
