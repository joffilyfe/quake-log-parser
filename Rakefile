# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'optparse'
require_relative 'lib/quake'

RSpec::Core::RakeTask.new(:spec)

desc 'Run the parser through the log file'
namespace :quake do
  namespace :log do
    task :parse do
      params = {}
      options = OptionParser.new do |opts|
        opts.on('-l', '--log FILE', 'The Quake server log file')
      end

      options.parse!(into: params)

      if params[:log].nil?
        puts options
        exit(1)
      end

      parser = Quake::Log::Parser.new(File.open(params[:log])).parse!

      parser.games.each_with_index do |match, index|
        pp({ "game_#{index + 1}": match })
      end
    end
  end
end
