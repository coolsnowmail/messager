#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.dirname(__FILE__)
['ext', 'lib'].each do |dir|
  $: << File.join(File.dirname(File.expand_path(File.dirname(__FILE__))), dir)
end

#require 'json'
require 'oj'

Oj.mimic_JSON()
require 'pact'

puts "*** responds? #{Regexp.respond_to?(:json_create)}"

j = /1/.to_json

puts "json: #{j}"

puts "regexp: #{JSON.load(j)}"
