require 'json'
require 'optparse'

desc 'Run the parser through the log file'
namespace :quake do
  namespace :log do
    task :parse do
      params = {}
      options = OptionParser.new do |opts|
        opts.on('-l', '--log FILE', 'The Quake server log file')
        opts.on('-j', '--json', 'Output parsed result as JSONL')
      end

      options.parse!(into: params)

      if params[:log].nil?
        puts options
        exit(1)
      end

      params[:fomatter] = ->(data) { data }
      params[:fomatter] = ->(data) { JSON.dump(data) } unless params[:json].nil?

      parser = Quake::Log::Parser.new(File.open(params[:log])).parse!

      parser.games.each_with_index do |match, index|
        puts params[:fomatter].call(
          ({ "game_#{index + 1}": match })
        )
      end
    end
  end
end
