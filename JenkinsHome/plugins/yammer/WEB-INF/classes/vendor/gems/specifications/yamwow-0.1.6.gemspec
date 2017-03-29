# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yamwow}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Matthew Riley}]
  s.date = %q{2013-06-24}
  s.email = %q{matthew-github@matthewriley.name}
  s.homepage = %q{http://rubygems.org/gems/yamwow}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{YamWow is a Ruby Gem built on top of the Yammer REST API to help you get more out of Yammer.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hash_flattener>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<hash_to_csv>, ["~> 0.1.0"])
      s.add_runtime_dependency(%q<yam>, ["~> 0.0.6"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec-mocks>, [">= 0"])
    else
      s.add_dependency(%q<hash_flattener>, ["~> 0.2.0"])
      s.add_dependency(%q<hash_to_csv>, ["~> 0.1.0"])
      s.add_dependency(%q<yam>, ["~> 0.0.6"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec-mocks>, [">= 0"])
    end
  else
    s.add_dependency(%q<hash_flattener>, ["~> 0.2.0"])
    s.add_dependency(%q<hash_to_csv>, ["~> 0.1.0"])
    s.add_dependency(%q<yam>, ["~> 0.0.6"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec-mocks>, [">= 0"])
  end
end
