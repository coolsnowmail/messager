#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

#require 'json'
require 'oj'
Oj.mimic_JSON

JSON.dump_default_options[:ascii_only]=true
puts JSON.dump_default_options

puts JSON.dump(["a😬sdf"])

JSON.dump_default_options = {:ascii_only=>false}

puts JSON.dump_default_options
