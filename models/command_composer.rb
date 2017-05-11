require 'active_support/all'

class CommandComposer

  attr_reader :branch, :topic, :reviewers

  def initialize(branch:, options: {})
    @branch = branch
    @topic = options[:topic] || ''
    @reviewers = options[:reviewers] || []
  end

  def push
    "git push origin HEAD:refs/for/#{branch}#{options_query_string}"
  end

  private

  def options_query_string
    return if topic.blank? && reviewers.blank?
    "%#{[topic_query_string, reviewers_query_string].compact.join(',')}"
  end

  def topic_query_string
    return if topic.blank?
    "topic=#{topic}"
  end

  def reviewers_query_string
    return if reviewers.blank?
    "r=#{reviewers.join(',r=')}"
  end

end