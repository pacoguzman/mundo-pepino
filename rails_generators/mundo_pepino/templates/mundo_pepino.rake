$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
$:.unshift(RAILS_ROOT + '/vendor/plugins/mundo-pepino/lib')
gem 'cucumber' unless File.directory?(File.join(Rails.root, 'vendor/plugins/cucumber'))
require 'cucumber/rake/task'

Cucumber::Rake::Task.new({:caracteristicas => 'db:test:prepare'}) do |t|
  t.fork = true # You may get faster startup if you set this to false
  t.profile = 'default'
  t.cucumber_opts = "--format pretty"
end
