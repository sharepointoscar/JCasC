# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hash_flattener}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Matthew Riley}]
  s.date = %q{2013-03-18}
  s.email = %q{matthew-github@matthewriley.name}
  s.homepage = %q{http://rubygems.org/gems/hash_flattener}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Hash Flattener is a Ruby Gem that recursively flattens a Hash using breadcrumbs as keys.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
