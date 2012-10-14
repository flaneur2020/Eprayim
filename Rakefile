$:.unshift << File.dirname(__FILE__)

task :default => :test

desc 'test all'
task :test do
  Dir['test/test_*.rb'].each do |fn|
    require fn
  end
end

desc 'build gem'
task :gem do
  sh 'gem build eprayim.gemspec'
end

