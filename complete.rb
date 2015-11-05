#!/usr/bin/ruby
require 'JSON'
require 'stringio'


file_contents = ''
stdin_present = false
if STDIN.tty?
  file_contents = IO.read ARGF.argv[0]
else
  file_contents = $stdin.read
  stdin_present = true
end

file_offset = 0

num_args = ARGF.argv.length
arg_offset = stdin_present ? -1 : 0

if ARGF.argv.length == 3 || (stdin_present && num_args == 2)
  target_line = ARGF.argv[1 + arg_offset].to_i
  target_offset = ARGF.argv[2 + arg_offset].to_i

  # $/ is a ruby builtin that gets you the current system's line separator
  file_contents.split($/).each.with_index do |line, num|
    if (num + 1) == target_line
      file_offset += target_offset
      break
    end
    file_offset += line.length + $/.length
  end
elsif ARGF.argv.length == 2 || (stdin_present && num_args == 1)
  file_offset = ARGF.argv[1 + arg_offset].to_i
else
  puts "Usage:\n ./complete.rb <filepath> (<char offset>)|(<line> <column>)"
  puts "OR\n cat <filepath> | ./complete.rb (<char offset>)|(<line> <column>)"
  exit
end


json_output = `curl -s -G "http://localhost:8080/xtext-service/assist?resource=text.statemachine&caretOffset=#{file_offset}" --data-urlencode "fullText=#{file_contents}" -X POST`

json = JSON.parse(json_output)

s = StringIO.new
json['entries'].each do |entry|
  s << entry['proposal']
  s << "\n"
end
puts s.string
