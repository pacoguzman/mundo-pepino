require 'string-mapper'
require 'definiciones/dado_contexto'
require 'definiciones/cuando_ocurre'
require 'definiciones/entonces_pasa'

String.add_mapper :model
String.add_mapper :field
String.add_mapper :name_field
String.add_mapper(:url, 
  /la (portada|home)/i => '/') { |string| string }
String.add_mapper(:number, { 
  /un[oa]?$/i => 1,
  :dos    => 2,
  :tres   => 3,
  :cuatro => 4 }) { |string| string.to_i }


class MundoPepino < Cucumber::Rails::World
  include FixtureReplacement

  class ResourceNotFound < RuntimeError
    def initialize(resource_info=nil)
      @resource_info = resource_info && " (#{resource_info})"
    end
    def message
      "Resource not found#{@resource_info}"
    end
  end

  class WithoutResources < ResourceNotFound
    def initialize
      super 'there is no resources'
    end
  end

  class NotMapped < RuntimeError
    def initialize(type, string)
      @type = type
      @string = string
    end
    def message
      "#{@type} not mapped '#{@string}'"
    end
  end
  class ModelNotMapped < NotMapped
    def initialize(string)
      super('Field', string)
    end
  end
  class FieldNotMapped < NotMapped
    def initialize(string)
      super('Field', string)
    end
  end

  def create(model, attributes = {})
    self.send "create_#{model.name.downcase}", attributes
  end

  def find_or_create(model_or_modelo, attribs = {}) 
    model = if model_or_modelo.is_a?(String)
      model_or_modelo.to_model
    else
      model_or_modelo
    end
    if attribs.any? and (obj = model.find(:first, :conditions =>
       [attribs.keys.map{|s| s+'=?'}.join(' AND ')] + attribs.values ))
      obj
    else
      create model, attribs
    end
  end

  def add_resource(model, attribs=[])
    @resources ||= []
    attributes = if attribs.is_a?(Hash)
      [ attribs ] 
    else
      attribs
    end
    @resources.unshift(if attributes.size == 1
      find_or_create(model, attributes.first)
    else
      attributes.map {|hash| find_or_create(model, hash) }
    end)
    @resources.first
  end
  
  def name_field_for(modelo)
    modelo.to_name_field || 'nombre'.to_field || 'name'
  end
  def shouldify(should_or_not)
    should_or_not.downcase == 'debo' ? :should : :should_not
  end

  def not_shouldify(should_or_not)
    shouldify(should_or_not) == :should ? :should_not : :should
  end

  def unquote(string_or_array)
    if string_or_array.is_a?(Array)
      string_or_array.map { |str| unquote(str) }
    else
      string_or_array =~ /^['"](.*)['"]$/ ? $1 : string_or_array
    end
  end
  
  def last_resource
    @resources && @resources.first
  end

  def last_resource_url
    if res = last_resource
      eval("#{res.class.name.downcase}_path(#{res.id})")
    else
      raise WithoutResources
    end
  end

  def last_resource_of(modelo)
    if model = modelo.to_model
      if (array = last_resource) and 
         (array.is_a?(Array)) and
         (array.first.is_a?(model))
        array
      else
        detect_first @resources, :is_a?, model
      end
    else
      raise ModelNotMapped.new(modelo)
    end
  end

  def detect_first(arr, method, value)
    if value.is_a? String
      method ||= :name
      arr.detect { |r| r.respond_to?(method) && (r.send(method) =~ /#{value}/i) }
    elsif value.is_a? Class
      method ||= :is_a?
      arr.detect { |r| r.respond_to?(method) && r.send(method, value) }
    else
      method ||= :id
      arr.detect { |r| r.respond_to?(method) && r.send(method) == value }
    end
  end
  
end
