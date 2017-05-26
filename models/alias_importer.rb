require 'yaml'

class AliasImporter

  attr_reader :alias_file_path

  def initialize(alias_file_path: "#{Dir.home}/.gitgerrit/alias.yaml")
    @alias_file_path = alias_file_path
  end

  def parse_aliases
    YAML.load_file alias_file_path
  end

end