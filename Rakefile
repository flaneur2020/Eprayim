$:.unshift << File.dirname(__FILE__)

desc 'test all'
task :test do
  Dir['test/test_*.rb'].each do |fn|
    require fn
  end
end
