lib = File.expand_path('lib', File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'timeshifter/version'


#############################################################################
#
# Standard tasks
#
#############################################################################

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "timeshifter #{Timeshifter::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :console do
  sh "irb -rubygems -I lib -r timeshifter"
end


#############################################################################
#
# Packaging tasks
#
#############################################################################

task :release => :build do
  unless `timeshifter branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  sh "gem build timeshifter.gemspec"
  sh "timeshifter commit --allow-empty -a -m 'Release #{Timeshifter::VERSION}'"
  sh "timeshifter tag v#{Timeshifter::VERSION}"
  sh "timeshifter push origin master"
  sh "timeshifter push origin v#{Timeshifter::VERSION}"
end
