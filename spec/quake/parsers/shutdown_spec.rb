RSpec.describe Quake::Log::Parsers::Shutdown do
  subject { Quake::Log::Parsers::Shutdown.new }

  let (:valid_shutdown_line) { '20:34 ShutdownGame:' }
  let (:valid_shutdown_line_with_spaces) { " #{valid_shutdown_line} " }
  let (:invalid_shutdown_line) { '20:34 ---Invalid--ShutdownGame:' }

  describe('#parse?') do
    it('returns true when line has a shutdown event') do
      expect(subject.parse?(valid_shutdown_line)).to be(true)
    end

    it('returns true even if line is not striped') do
      expect(subject.parse?(valid_shutdown_line_with_spaces)).to be(true)
    end

    it('returns false if line is empty') do
      expect(subject.parse?('')).to be(false)
    end

    it('returns false if the line is not well formed') do
      expect(subject.parse?(invalid_shutdown_line)).to be(false)
    end
  end

  describe('#parse') do
    it('returns a Entity::Player object') do
      expect(subject.parse(valid_shutdown_line).class).to be(Quake::Log::Entities::Shutdown)
    end
  end
end
