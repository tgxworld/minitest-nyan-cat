require "minitest"
require 'nyan_cat_formatter/common'

module Minitest
  def self.plugin_nyan_cat_options(opts, _options)
    opts.on "-nyan", "--nyancat", "Nyan nyan nyan nyan nyan nyan nyan nyan nyan" do
      NyanCat.nyan!
    end
  end

  def self.plugin_nyan_cat_init(options)
    if NyanCat.nyan? then
      io = NyanCat.new options[:io]

      self.reporter.reporters.grep(Minitest::Reporter).each do |rep|
        rep.io = io
      end
    end
  end

  class NyanCat
    include ::NyanCat::Common

    attr_reader :output

    def initialize(io)
      @example_count = total_count
      @current = @color_index = @passing_count = @failure_count = @pending_count = 0
      @example_results = []
      @output = io
    end

    def self.nyan!
      @nyan = true
    end

    def self.nyan?
      @nyan ||= false
    end

    def print(o)
      case o
      when "." then
        @passing_count += 1
        tick PASS
      when "E", "F" then
        @failure_count += 1
        tick FAIL
      when "S" then
        @pending_count += 1
        tick PENDING
      else
        output.print o
      end
    end

    def puts(*o)
      if o.first =~ /Finished in (.+)s/
        output.puts "\nYou've Nyaned for #{format_duration($1.to_f)}\n".each_char.map {|c| rainbowify(c)}.join
        summary = "#{@example_count} example#{'s' unless @example_count == 1}, #{@failure_count} failure#{'s' unless @failure_count == 1}"
        summary << ", #{@pending_count} pending" if @pending_count > 0

        if @failure_count > 0
          # Red background with white chars
          output.puts "#{ESC}41m#{ESC}37m#{summary}#{NND}\n"
        elsif pending_count > 0
          # Gray background with white chars
          output.puts "#{ESC}43m#{ESC}40m#{summary}#{NND}\n"
        else
          # Green background with white chars
          output.puts "#{ESC}42m#{ESC}37m#{summary}#{NND}\n"
        end
      elsif o.first =~ /runs/
      else
        output.puts(o)
      end
    end

    def method_missing(msg, *args)
      output.send(msg, *args)
    end

    private

    # Hack to get the total number of assertions
    def total_count
      Minitest::Runnable.runnables.map(&:runnable_methods).flatten.size
    end

    # Override method since it assumes RSpec is used
    def wrap(text, code_or_symbol)
      text
    end

    # Override to make it work with Minitest
    def success_color(text)
      "#{ESC}32m#{text}#{NND}"
    end

    # Override to make it work with Minitest
    def pending_color(text)
      "#{ESC}33m#{text}#{NND}"
    end

    # Override to make it work with Minitest
    def failure_color(text)
      "#{ESC}31m#{text}#{NND}"
    end

    # Override to make it work with Minitest
    def scoreboard
      padding = @example_count.to_s.length

      [
        @current.to_s.rjust(padding),
        success_color(@passing_count.to_s.rjust(padding)),
        failure_color(@failure_count.to_s.rjust(padding)),
        pending_color(@pending_count.to_s.rjust(padding))
      ]
    end
  end
end
