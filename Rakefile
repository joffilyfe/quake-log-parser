# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require_relative 'lib/quake'

RSpec::Core::RakeTask.new(:spec)

Dir.glob('./lib/tasks/quake/*.rake').each { |r| load r}
