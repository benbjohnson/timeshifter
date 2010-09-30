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

task :release do
  puts ""
  puts "Are you sure you want to relase Timeshifter #{Timeshifter::VERSION}?"
  print "[y/N] "
  exit unless STDIN.gets.index(/y/i) == 0
  
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  
  # Build gem and upload
  sh "gem build timeshifter.gemspec"
  sh "gem push timeshifter-#{Timeshifter::VERSION}.gem"
  sh "rm timeshifter-#{Timeshifter::VERSION}.gem"
  
  # Commit
  sh "git commit --allow-empty -a -m 'v#{Timeshifter::VERSION}'"
  sh "git tag v#{Timeshifter::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{Timeshifter::VERSION}"
end
