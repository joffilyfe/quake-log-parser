RSpec.describe Quake::Log::Entities::Kill do
  let (:data) do
    {
      assassin: 'player 1', by: 'reason', assassin_id: '1', assassinated_id: '2'
    }
  end

  subject { Quake::Log::Entities::Kill.new(data) }

  describe('#data') do
    it('should has this method') do
      expect(subject.respond_to?(:data)).to be(true)
    end

    it('returns a new game data') do
      expect(subject.data).to eq(data)
    end
  end

  describe('#assssin') do
    it('returns the assissin nick name') do
      expect(subject.assassin).to eq('player 1')
    end
  end

  describe('#by_player?') do
    it('returns true when the assassin is a player') do
      expect(subject.by_player?).to be(true)
    end

    it('returns false when the assassin is <world>') do
      kill = Quake::Log::Entities::Kill.new({ assassin: '<world>' })

      expect(kill.by_player?).to be(false)
    end
  end

  describe('#by_world?') do
    it('returns false when the assassin is a player') do
      expect(subject.by_world?).to be(false)
    end

    it('returns true when the assassin is <world>') do
      kill = Quake::Log::Entities::Kill.new({ assassin: '<world>' })

      expect(kill.by_world?).to be(true)
    end
  end

  describe('#by') do
    it('returns the reason for the kill') do
      expect(subject.by).to eq('reason')
    end
  end

  describe('#assassin_id') do
    it('returns the assassin id for the kill') do
      expect(subject.assassin_id).to eq(1)
    end
  end

  describe('#assassinated_id') do
    it('returns the assassinnated id for the kill') do
      expect(subject.assassinated_id).to eq(2)
    end
  end
end
