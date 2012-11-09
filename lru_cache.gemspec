Gem::Specification.new do |s|
  s.name          = 'lru_cache'
  s.version       = '1.0.0'
  s.authors       = ['Brendan Baldwin']
  s.email         = ['brendan@usergenic.com']
  s.homepage      = 'https://github.com/brendan/lru_cache'
  s.summary       = %q{a simple LRU cache in ruby that uses a doubley-linked list and a hash}
  s.description   = %q{its performant / constant o(1)}
  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(/^bin\//).map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec'
end

