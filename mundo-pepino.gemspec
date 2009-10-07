# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mundo-pepino}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fernando Garc\303\255a Samblas"]
  s.date = %q{2009-10-07}
  s.description = %q{}
  s.email = ["fernando.garcia@the-cocktail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["COPYING", "History.txt", "Manifest.txt", "README.markdown", "doc", "init.rb", "lib/mundo_pepino.rb", "lib/mundo_pepino/definitions/es_ES.rb", "lib/mundo_pepino/resources_history.rb", "lib/mundo_pepino/version.rb", "lib/mundo_pepino/visits_history.rb", "lib/mundo_pepino_es_ES.rb", "rails_generators/caracteristica/USAGE", "rails_generators/caracteristica/caracteristica_generator.rb", "rails_generators/caracteristica/templates/caracteristica.erb", "rails_generators/mundo_pepino/USAGE", "rails_generators/mundo_pepino/mundo_pepino_generator.rb", "rails_generators/mundo_pepino/templates/mundo_pepino.rake", "rails_generators/mundo_pepino/templates/mundo_pepino_es_ES.rb"]
  s.homepage = %q{http://github.com/nando/mundo-pepino}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{mundo-pepino}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{MundoPepino is a set of reusable step definitions to test Rails apps with Cucumber}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<cucumber>, [">= 0.3.102"])
      s.add_runtime_dependency(%q<webrat>, [">= 0.5.3"])
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_runtime_dependency(%q<rspec-rails>, [">= 1.2.6"])
      s.add_runtime_dependency(%q<string-mapper>, [">= 0.1.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<rails>, [">= 2.0.0"])
      s.add_dependency(%q<cucumber>, [">= 0.3.102"])
      s.add_dependency(%q<webrat>, [">= 0.5.3"])
      s.add_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_dependency(%q<rspec-rails>, [">= 1.2.6"])
      s.add_dependency(%q<string-mapper>, [">= 0.1.0"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<rails>, [">= 2.0.0"])
    s.add_dependency(%q<cucumber>, [">= 0.3.102"])
    s.add_dependency(%q<webrat>, [">= 0.5.3"])
    s.add_dependency(%q<rspec>, [">= 1.2.6"])
    s.add_dependency(%q<rspec-rails>, [">= 1.2.6"])
    s.add_dependency(%q<string-mapper>, [">= 0.1.0"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
