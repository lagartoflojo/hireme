require 'rubygems'
require 'typhoeus'
require 'yajl'

def get_repos username
  #response = Yajl::Parser.parse Nestful.get("https://api.github.com/users/#{username}/repos"), symbolize_keys: true
  #response.collect { |repo| repo[:language] }.compact.sort
  response = Typhoeus::Request.get("https://api.github.com/users/#{username}/repos")
  response.headers
end


p get_repos "defunkt"