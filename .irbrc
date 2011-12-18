#!/usr/bin/env ruby

# Require all the necessary gems
missing_libs = Array.new
%w{ rubygems irb/completion irb/ext/save-history looksee/shortcuts uri open-uri duration net/http }.each do |lib|
  begin
    require lib
  rescue LoadError
    missing_libs << lib
  end
end
puts "Missing following libraries: #{missing_libs.join(', ')}" if missing_libs.size > 0

#require 'wirble'
#if defined?(Wirble)
#  Wirble.init
#  Wirble.colorize
#end

# History / Prompt / Auto Indent
if defined?(IRB)
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
  IRB.conf[:AUTO_INDENT] = true
end

# Easily print methods local to an object's class
class Object
  def looksee
    lp self
  end

  def methods(query = "")
    super.select { |name| name.to_s.include?(query.to_s) }.sort
  end

  def local_methods(query = "")
    (methods - Object.instance_methods).select { |name| name.to_s.include?(query.to_s) }.sort
  end
  alias lm local_methods
end

# Aliases
alias q exit

def hist
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') || defined?(RAILS_ENV)
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

### irb session duration
if defined?(Duration)
  IRB_START_TIME = Time.now
  at_exit { puts "\nirb session duration: #{Duration.new(Time.now - IRB_START_TIME)}" }
end
