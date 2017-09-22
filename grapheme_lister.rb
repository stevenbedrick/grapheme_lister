# grapheme_lister.rb
# Written in 2017 by Steven Bedrick (bedricks@ohsu.edu)
# 
# Be

require 'unicode_utils'
require 'optparse'

options = {:extra_line => false}
OptionParser.new do |opts|
  opts.banner = "Usage: grapheme_lister.rb [options]"
  opts.on("-f", "--file [FILE]", "File to print") do |f|
    options[:file] = f
  end
  
  opts.on("-e", "--extra-line", "Extra blank line between clusters?") do |e|
    options[:extra_line] = e
  end
  
end.parse!

if not options[:file]
  STDERR.puts "File not specified."
  exit(-1)
end

if not File.exists? options[:file]
  STDERR.puts "File not found."
  exit(-1)
end

s = File.open(options[:file]).readlines.join

UnicodeUtils.each_grapheme(s).to_a.each_with_index do |g, grapheme_idx|

  code_points = g.each_codepoint.to_a
  
  if code_points.size == 1
    puts "#{grapheme_idx}\t#{g}\t#{code_points[0].to_s(16)}\t#{UnicodeUtils.char_name(g)}"
  else
    puts "#{grapheme_idx}\t#{g}\tCLUSTER:"
    g.each_codepoint do |x|
      puts "\t#{[x].pack("U*")}\t#{x.to_s(16)}\t#{UnicodeUtils.char_name(x)}"
    end
    
    if options[:extra_line]
      puts
    end
    
  end
  
end