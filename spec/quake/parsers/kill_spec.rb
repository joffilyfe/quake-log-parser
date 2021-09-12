RSpec.describe Quake::Log::Parsers::Kill do
  subject { Quake::Log::Parsers::Kill.new }

  let (:valid_kill_line) { '1:26 Kill: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT' }
  let (:valid_kill_line_with_spaces) { " #{valid_kill_line} " }
  let (:invalid_kill_line) { '00:09 xInvalidKillx: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT' }

  describe('#parse?') do
    it('returns true when line has the kill information') do
      expect(subject.parse?(valid_kill_line)).to be(true)
    end

    it('returns true even if line is not striped') do
      expect(subject.parse?(valid_kill_line_with_spaces)).to be(true)
    end

    it('returns false if line is empty') do
      expect(subject.parse?('')).to be(false)
    end

    it('returns false if the line is not well formed') do
      expect(subject.parse?(invalid_kill_line)).to be(false)
    end
  end

  describe('#parse') do
    it('returns a Entity::Kill object') do
      expect(subject.parse(valid_kill_line).class).to be(Quake::Log::Entities::Kill)
    end
  end
end
