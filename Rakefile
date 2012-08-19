$:.unshift << File.dirname(__FILE__)

task :default => :test

desc 'test all'
task :test do
  Dir['test/test_*.rb'].each do |fn|
    require fn
  end
end
