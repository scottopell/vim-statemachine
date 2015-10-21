#!/usr/bin/ruby
require 'JSON'
require 'stringio'

file_contents = IO.read ARGF.argv[0]

target_line = ARGF.argv[1].to_i
target_offset = ARGF.argv[2].to_i

file_offset = 0

File.open(ARGF.argv[0]).each.with_index do |line, num|
  if (num + 1) == target_line
    file_offset += target_offset
    break
  end
  file_offset += line.length
end

json_output = `curl -s -G "http://localhost:8080/xtext-service/assist?resource=text.statemachine&caretOffset=#{file_offset}" --data-urlencode "fullText=#{file_contents}" -X POST`

json = JSON.parse(json_output)

s = StringIO.new
json['entries'].each do |entry|
  s << entry['proposal']
  s << "\n"
end
puts s.string
