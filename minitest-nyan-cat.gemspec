Gem::Specification.new do |s|
  s.name        = 'minitest-nyan-cat'
  s.version     = '0.0.1'
  s.date        = '2015-05-20'
  s.summary     = "Prints a Nyan Cat trail for your test output"
  s.authors     = ["Alan Guo Xiang Tan"]
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = 'https://github.com/tgxworld/minitest-nyan-cat'
  s.license       = 'MIT'

  s.add_dependency 'nyan-cat-formatter', '0.11'
end
