# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cure/version"

Gem::Specification.new do |s|
  s.name        = "cure"
  s.version     = Cure::VERSION
  s.authors     = ["Jon Phenow"]
  s.email       = ["j.phenow@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = "cure"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "patron"
end
