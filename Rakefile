require 'rubygems'
require 'rake'

require 'spec/rake/spectask'
desc "Run all examples"
Spec::Rake::SpecTask.new('test') do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sermonator #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

