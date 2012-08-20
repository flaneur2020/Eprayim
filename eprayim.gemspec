Gem::Specification.new do |s|
  s.name = "eprayim"
  s.version = "0.1"
  s.author = "fleuria"
  s.homepage = "http://github.com/Fleurer/Eprayim"
  s.platform = Gem::Platform::RUBY
  s.summary = "A simple, sometimes naive markup language interpreter."
  s.description = "Inspired by markdown, txt2tags and so on."
  s.required_ruby_version = ">=1.9.1"
  s.files = Dir.glob("{LICENSE,README.md,lib/**/*.rb,test/*.rb}")
  s.require_paths = ["lib"]
  s.rubygems_version = '1.8.24'
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.md"]
end
