require_relative "lib/simple/lazy"

Gem::Specification.new do |spec|
  spec.name = "simple-lazy"
  spec.version = Simple::Lazy::VERSION
  spec.authors = ["localhostdotdev"]
  spec.email = ["localhostdotdev@protonmail.com"]
  spec.summary = "lazy loading, e.g. Simple::Lazy.new(1) { |id| User.find(id) }"
  spec.homepage = "https://github.com/simple-updates/simple-lazy"
  spec.license = "MIT"
  spec.files = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]
end
