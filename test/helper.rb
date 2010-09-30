lib = File.expand_path('../lib', File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'minitest/autorun'
require 'timeshifter'
