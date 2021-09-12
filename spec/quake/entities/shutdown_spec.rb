RSpec.describe Quake::Log::Entities::Shutdown do
  subject { Quake::Log::Entities::Shutdown.new }

  describe('#data') do
    it('should has this method') do
      expect(subject.respond_to?(:data)).to be(true)
    end
  end
end
