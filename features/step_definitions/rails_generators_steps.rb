Given /^a Rails app$/ do
  FileUtils.chdir(@tmp_root) do
    `rails my_project`
  end
  @active_project_folder = File.expand_path(File.join(@tmp_root, "my_project"))
end

When /^I run executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "#{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

Given /^"(.+)" in "(.+)" as one of its plugins$/ do |plugin, path|
  # TODO fix this we can't link cucumber and cucumber-rails to vendor/plugins
  if plugin == 'mundo-pepino'
    # TO avoid recursive symbolic links not link features/support/app
    When 'I run executable "mkdir" with arguments "-p vendor/plugins/'+plugin+'/features/support"'
    When 'I run executable "ln" with arguments "-s ../../../../../rails_generators vendor/plugins/'+plugin+'/rails_generators"'
    When 'I run executable "ln" with arguments "-s ../../../../../lib vendor/plugins/'+plugin+'/lib"'
    When 'I run executable "ln" with arguments "-s ../../../../../../features/en_US vendor/plugins/'+plugin+'/features/en_US"'
    When 'I run executable "ln" with arguments "-s ../../../../../../features/es_ES vendor/plugins/'+plugin+'/features/es_ES"'
    When 'I run executable "ln" with arguments "-s ../../../../../../features/lib vendor/plugins/'+plugin+'/features/lib"'
    When 'I run executable "ln" with arguments "-s ../../../../../../features/rails_generators vendor/plugins/'+plugin+'/features/rails_generators"'
    When 'I run executable "ln" with arguments "-s ../../../../../../features/step_definitions vendor/plugins/'+plugin+'/features/step_definitions"'
    When 'I run executable "ln" with arguments "-s ../../../../../../../features/support/env.rb vendor/plugins/'+plugin+'/features/support/env.rb"'
    When 'I run executable "ln" with arguments "-s ../../../../../../../features/support/rails_generators_env.rb vendor/plugins/'+plugin+'/features/support/rails_generators_env.rb"'
    When 'I run executable "ln" with arguments "-s ../../../../../init.rb vendor/plugins/'+plugin+'/init.rb"'
    When 'I run executable "ln" with arguments "-s ../../../../../mundo-pepino.gemspec vendor/plugins/'+plugin+'/mundo-pepino.gemspec"'
    When 'I run executable "ln" with arguments "-s ../../../Rakefile vendor/plugins/'+plugin+'/Rakefile"'
  else
    When 'I run executable "ln" with arguments "-s ../../../../'+path+' vendor/plugins/'+plugin+'"'
  end
end

When /^I invoke "(.*)" generator with arguments "(.*)"$/ do |generator, arguments|
  @stdout = StringIO.new
  in_project_folder do
    if Object.const_defined?("APP_ROOT")
      APP_ROOT.replace(FileUtils.pwd)
    else 
      APP_ROOT = FileUtils.pwd
    end
    run_generator(generator, arguments.split(' '), SOURCES, :stdout => @stdout)
  end
  File.open(File.join(@tmp_root, "generator.out"), "w") do |f|
    @stdout.rewind
    f << @stdout.read
  end
end

When /^I invoke task "rake (.*)"/ do |task|
  @stdout = File.expand_path(File.join(@tmp_root, "rake.out"))
  @stderr = File.expand_path(File.join(@tmp_root, "rake.err"))
  in_project_folder do
    system "rake #{task} --trace > #{@stdout} 2> #{@stderr}"
  end
end

Then /^I should see '([^\']*)'$/ do |text|
  actual_output = File.read(@stdout)
  actual_output.should contain(text)
end

Then /^I should see '([^\']*)' in (.+)$/ do |text, path|
  in_project_folder do
    content = File.read(path)
    content.should contain(text)
  end
end

Given /^I replace "(.+)" with "(.+)" in (.+)$/ do |from, to, path|
  in_project_folder do
    content = File.read(path).gsub(from, to)
    File.open(path, 'wb') { |file| file.write(content) }
  end
end
