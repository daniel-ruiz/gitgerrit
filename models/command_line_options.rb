require 'optparse'

class CommandLineOptions

  attr_reader :branch, :topic, :reviewers, :parser

  def initialize
    @reviewers = []
    @parser = configure_parser
  end

  def parse_arguments_from(source)
    parser.parse(source)
  end

  private

  def configure_parser
    OptionParser.new do |parser|
      parser.banner = 'Usage: gitgerrit -b branch [OPTIONS]'
      parser.separator ''

      parser.on('-b', '--branch branch', `git branch`.split("\n").map!(&:chomp).map!(&:lstrip),
                'Specify the branch in which the change will be pushed') do |branch|
        @branch = branch
      end

      parser.separator ''
      parser.separator 'OPTIONS'

      parser.on('-t', '--topic [TOPIC]', 'Define change topic') do |topic|
        @topic = topic
      end

      parser.on('-r', '--reviewers [reviewer1,reviewer2]', Array, 'Specify change reviewers') do |reviewers|
        @reviewers = reviewers
      end

      parser.on_tail('-h', '--help', 'Show this message') do
        puts parser
        exit
      end
    end
  end
end