require 'rubygems'
require 'bundler'
Bundler.require

require File.join File.dirname(__FILE__), 'init.rb'
require File.join File.dirname(__FILE__), 'lib/github.rb'
require File.join File.dirname(__FILE__), 'lib/search.rb'
require File.join File.dirname(__FILE__), 'models/user.rb'


run HireMe::Init.new
