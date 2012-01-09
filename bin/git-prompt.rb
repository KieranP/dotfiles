#!/usr/bin/env ruby

# One super quick Git command gives us a ton of awesome!

class GitConsoleStats

  #
  # Configuration
  #

  @@default_color = 'black'
  @@branch_color = 'magenta'
  @@modified_color = 'red'
  @@not_modified_color = 'green'

  # Dont touch past here unless you want to

  @@colors = { 'black' => "\033[0;30m",
               'red' => "\033[0;31m",
               'green' => "\033[0;32m",
               'brown' => "\033[0;33m",
               'blue' => "\033[0;34m",
               'magenta' => "\033[0;35m",
               'cyan' => "\033[0;36m",
               'white' => "\033[0;37m" }

  @@default_color = @@colors[@@default_color]
  @@branch_color = @@colors[@@branch_color]
  @@modified_color = @@colors[@@modified_color]
  @@not_modified_color = @@colors[@@not_modified_color]

  def print
    return if git_status.nil? || git_status.empty? || git_status.include?('fatal')

    info = Array.new
    info << "#{untracked_files_count} untracked" if untracked_files_count > 0
    info << "#{new_files_count} new" if new_files_count > 0
    info << "#{modified_files_count} modified" if modified_files_count > 0
    info << "#{deleted_files_count} deleted" if deleted_files_count > 0
    info << "#{renamed_files_count} renamed" if renamed_files_count > 0
    info << "#{copied_files_count} copied" if copied_files_count > 0
    info << "#{merge_conflicts_count} merge conflict#{'s' if merge_conflicts_count > 1}" if merge_conflicts_count > 0

    modified_info = (info.size > 0) ? "#{@@modified_color}modified (#{info.join(', ')})" : "#{@@not_modified_color}not modified"
    puts "- #{@@branch_color}#{branch_name}#{@@default_color} - #{modified_info}#{@@default_color}"
  end

  def git_status
    @@git_status ||= `git status -sb 2>/dev/null`
  end

  def branch_name
    @@branch_name ||= git_status =~ /^##\s([^\[$\n]*)/ ? $1.strip.split('...').first : '[unknown branch]'
  end

  def untracked_files_count
    @@untracked_files_count ||= git_status.scan(/^\?\?/).size
  end

  def new_files_count
    @@new_files_count ||= git_status.scan(/^(A.|.A)/).size
  end

  def modified_files_count
    @@modified_files_count ||= git_status.scan(/^(M.|.M)/).size
  end

  def deleted_files_count
    @@deleted_files_count ||= git_status.scan(/^(D.|.D)/).size
  end

  def renamed_files_count
    @@renamed_files_count ||= git_status.scan(/^(R.|.R)/).size
  end

  def copied_files_count
    @@copied_files_count ||= git_status.scan(/^(C.|.C)/).size
  end

  def merge_conflicts_count
    @@merge_conflicts_count ||= git_status.scan(/^(D|U|T)(D|U|T)/).size
  end

end

GitConsoleStats.new.print
