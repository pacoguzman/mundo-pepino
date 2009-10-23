$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'mundo_pepino/base'
require 'mundo_pepino/implementations_api'
require 'mundo_pepino/implementations'
require 'mundo_pepino/resources_history'
require 'mundo_pepino/visits_history'
require 'mundo_pepino/version'
require 'mundo_pepino/config'

require 'string-mapper'

module MundoPepino
  include Base
  include ImplementationsApi
  include Implementations
  include ResourcesHistory
  include VisitsHistory

  class << self
    def extended(world)
      common_mappings world
      language_specific_mappings world
      user_specific_mappings world
    end

    def common_mappings(world)
      String.add_mapper :model
      String.add_mapper :relation_model
      String.add_mapper(:content_type,
        /\.png$/   => 'image/png',
        /\.jpe?g$/ => 'image/jpg',
        /\.gif$/   => 'image/gif') { |str| 'text/plain' }
      String.add_mapper(:underscored) { |string| string.gsub(/ +/, '_') }
      String.add_mapper(:unquoted) { |str| str =~ /^['"](.*)['"]$/ ? $1 : str}
      String.add_mapper(:translated) do |str|
        if str =~ /^[a-z_]+\.[a-z_]+[a-z_\.]+$/
          I18n.translate(str, :default => str)
        elsif str =~ /^([a-z_]+\.[a-z_]+[a-z_\.]+),(\{.+\})$/
          I18n.translate($1, {:default => str}.merge(eval($2)))
        else
          str
        end
      end
      String.add_mapper(:url) do |string|
        if world.respond_to? :path_to
          world.path_to string
        else
          string if string =~ /^\/.*$|^https?:\/\//i
        end
      end
    end

    def config
      @config ||= Config.new
    end

    def configure(&block)
      config.configure(&block)
    end

    def clean_models
      config.models_to_clean.each { |model| model.destroy_all }
    end
  end
end
