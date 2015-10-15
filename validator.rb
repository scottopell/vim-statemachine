#!/usr/bin/ruby
require 'JSON'
require 'stringio'

file_contents = IO.read ARGF.argv[0]

json_output = `curl -s -G "http://localhost:8080/xtext-service/validate?resource=text.statemachine" --data-urlencode "fullText=#{file_contents}" -X POST`

json = JSON.parse(json_output)
s = StringIO.new
json['issues'].each do |issue|
  s << issue['line']
  s << ': '
  s << issue['description']
  s << "\n"
end
puts s.string
