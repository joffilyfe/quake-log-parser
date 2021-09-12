RSpec.describe Quake::Log::Parsers::Game do
  subject { Quake::Log::Parsers::Game.new }

  describe('#parse?') do
    it('returns true when line has initial information for the game') do
      expect(subject.parse?('0:0 InitGame')).to be(true)
    end

    it('returns true even if line is not striped') do
      expect(subject.parse?(' 23:59 InitGame ')).to be(true)
    end

    it('returns false if line is empty') do
      expect(subject.parse?('')).to be(false)
    end

    it('returns false if the line has not the InitGame information') do
      expect(subject.parse?('00:00 Kill: 9 1 9: Player')).to be(false)
    end

    it('returns false if the line is not well formed') do
      expect(subject.parse?('---23:59-not-well-formed InitGame')).to be(false)
    end
  end

  describe('#parse') do
    it('returns a Entity::Game object') do
      expect(subject.parse.class).to be(Quake::Log::Entities::Game)
    end
  end
end
