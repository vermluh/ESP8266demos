#!/usr/bin/env ruby

# encoding: UTF-8

require 'net/http'
require 'uri'
require 'awesome_print'
require 'json/ext'

uri = URI.parse('http://192.168.4.1/relay')

Net::HTTP.new(uri.host, uri.port, nil, nil, nil, nil).start do |client|
  puts 'current relay state...'
  get_request = Net::HTTP::Get.new uri.request_uri
  get_request.basic_auth 'olimex', 'olimex'
  response = client.request get_request
  get_response =  JSON.parse response.body
  ap get_response

  relay_state = get_response['Data']['Relay']
  new_relay_state = (relay_state + 1) % 2

  puts 'setting new relay state...'
  post_request = Net::HTTP::Post.new uri.request_uri
  post_request.basic_auth 'olimex', 'olimex'
  post_request['content-type'] = 'text/plain;charset=utf-8'
  post_request.body = %*{"Relay" : #{new_relay_state}}*
  response = client.request post_request
  post_response = JSON.parse response.body
  ap post_response
end
