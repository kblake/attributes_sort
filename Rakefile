require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "attributes_sort"
    gem.summary = %Q{A slick way to sort a collection objects.}
    gem.description = %Q{Sort a collection of objects using one or more of the attributes of your object.}
    gem.email = "karmenblake@gmail.com"
    gem.homepage = "http://github.com/kblake/attributes_sort"
    gem.authors = ["Karmen Blake"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "attributes_sort #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
		gem.name = "attributes_sort"
    gem.summary = "A slick way to sort a collection objects."
    gem.description = "Sort a collection of objects using one or more of the attributes of your object."
    gem.email = "karmenblake@gmail.com"
    gem.homepage = "http://github.com/kblake/attributes_sort"
    gem.authors = ["Karmen Blake"]			
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

