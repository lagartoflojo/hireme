require 'rubygems'
require 'bundler'
Bundler.require

require File.join(File.dirname(__FILE__), 'github.rb')
require File.join(File.dirname(__FILE__), 'init.rb')

run HireMe::Init.new
