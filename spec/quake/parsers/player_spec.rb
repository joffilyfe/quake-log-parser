RSpec.describe Quake::Log::Parsers::Player do
  subject { Quake::Log::Parsers::Player.new }

  let (:valid_player_line) do
    '20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0'\
    '\model\xian/default\hmodel\xian/default\g_redteam'\
    '\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0'
  end

  let (:valid_player_line_with_spaces) { " #{valid_player_line} " }

  let (:invalid_player_line) do
    '20:34 ---Invalid--ClientUserinfoChanged: 2 n\Isgalamido\t\0'\
    '\model\xian/default\hmodel\xian/default\g_redteam'\
    '\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0'
  end

  describe('#parse?') do
    it('returns true when line has the player information') do
      expect(subject.parse?(valid_player_line)).to be(true)
    end

    it('returns true even if line is not striped') do
      expect(subject.parse?(valid_player_line_with_spaces)).to be(true)
    end

    it('returns false if line is empty') do
      expect(subject.parse?('')).to be(false)
    end

    it('returns false if the line is not well formed') do
      expect(subject.parse?(invalid_player_line)).to be(false)
    end
  end

  describe('#parse') do
    it('returns a Entity::Player object') do
      expect(subject.parse(valid_player_line).class).to be(Quake::Log::Entities::Player)
    end
  end
end
