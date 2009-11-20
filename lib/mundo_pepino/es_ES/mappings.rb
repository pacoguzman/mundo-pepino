module MundoPepino
  class << self
    include Matchers::Fragments
    def language_specific_mappings
      String.add_mapper(:real_value, {
        /^verdader[oa]$/i  => true,
        /^fals[ao]$/i      => false
      }) { |value| value }
      String.add_mapper(:field) { |str| :name if str =~ /^nombres?/ }
      
      String.add_mapper(:number, { 
        /^un[oa]?$/i     => 1,
        /^primer[oa]?$/i => 1,
        :dos             => 2,
        /^segund[oa]?$/i => 2,
        :tres            => 3,
        /^tercer[ao]/i   => 3,
        :cuatro          => 4,
        /^cuart[ao]/i    => 4,
        :cinco           => 5,
        /^quint[ao]/i    => 5,
        :seis            => 6,
        :siete           => 7,
        :ocho            => 8,
        :nueve           => 9,
        :diez            => 10
      }) { |string| string.to_i }
      String.add_mapper(:crud_action,
        /^alta(?: de (?:una? )?nuev[ao])?$/i         => 'new',
        /^creaci[óo]n(?: de (?:una? )?nuev[ao])?$/i  => 'new',
        /^nuev(?:o|a|o\/a|a\/o)$/i                   => 'new',
        /^inicio|comienzo$/i                         => 'new',
        /^cambio$/i                => 'edit',
        /^modificaci[oó]n(?:es)?$/i       => 'edit',
        /^edici[oó]n$/i            => 'edit')
      String.add_mapper(:month,
        :enero           => 'January',
        :febrero         => 'February',
        :marzo           => 'March',
        :abril           => 'April',
        :mayo            => 'May',
        :junio           => 'June',
        :julio           => 'July',
        :agosto          => 'August',
        /^sep?tiembre$/i  => 'September',
        :octubre         => 'October',
        :noviembre       => 'November',
        :diciembre       => 'December')
      unless self.world.respond_to? :path_to
<<<<<<< HEAD:lib/mundo_pepino/es_ES/mappings.rb
        String.url_mappings[/^la (?:portada|home\s?(?:page)?)$/i] = self.world.root_path
=======
        String.url_mappings.merge!({
          /^la (?:portada|home\s?(?:page)?)$/i => self.world.root_path,
          /^(#{_el_listado_de_}) ([\w]+|['"][\w ]+["'])$/i => 
            lambda{ |el_listado_de, modelo|
              MundoPepino.world.resource_index_or_mapped_page(el_listado_de, modelo)
            },
          /^su (p[áa]gina|portada)$/i => 
            lambda{MundoPepino.world.last_mentioned_url},
          /^#{_la_pagina_} (?:del|de la) (.+) ['"](.+)["']$/i =>
            lambda{|modelo, nombre|
              if resource = MundoPepino.world.last_mentioned_of(modelo, nombre)
                MundoPepino.world.send "#{resource.class.name.underscore}_path", resource
              else
                raise MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
              end
            },
          /^#{_la_pagina_} de (?!la)([\w\/]+(?: de (?:una? )?nuev[oa])?) (?:de |de la |del )?(.+?)(?: (['"].+["']))?$/i => 
            lambda{|accion, modelo, nombre|
              action = accion.to_crud_action or raise(MundoPepino::CrudActionNotMapped.new(accion))
              if action != 'new'
                nombre, modelo = modelo, nil unless nombre
                resource = if modelo && modelo.to_unquoted.to_model
                  MundoPepino.world.last_mentioned_of(modelo, nombre.to_unquoted)
                else
                  MundoPepino.world.last_mentioned_called(nombre.to_unquoted)
                end
                if resource
                  MundoPepino.world.send "#{action}_#{resource.mr_singular}_path", resource
                else
                  MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
                end
              else
                model = modelo.to_unquoted.to_model or raise(MundoPepino::ModelNotMapped.new(modelo))
                MundoPepino.world.pile_up model.new
                MundoPepino.world.send "#{action}_#{model.name.underscore}_path"
              end
            }
          })
>>>>>>> 8e405b406d1b78031b8e5c17cfe08360a9a82b27:lib/mundo_pepino/es_ES/mappings.rb
      end
    end
  end
end
