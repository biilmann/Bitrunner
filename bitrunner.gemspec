# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bitrunner/version"

Gem::Specification.new do |s|
  s.name        = "bitrunner"
  s.version     = Bitrunner::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mathias Biilmann"]
  s.email       = ["mathiasch@webpop.com"]
  s.homepage    = ""
  s.summary     = %q{API client for Bits on the run}
  s.description = %q{Simple API client for the Bits on the run video service}

  s.rubyforge_project = "bitrunner"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
