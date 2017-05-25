require 'optparse'

class CommandLineOptions

  attr_reader :topic, :reviewers, :parser

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
      parser.banner = 'Usage: gitgerrit BRANCH [OPTIONS]'
      parser.separator ''
      parser.separator 'BRANCH    Specify the branch in which the change will be pushed'
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