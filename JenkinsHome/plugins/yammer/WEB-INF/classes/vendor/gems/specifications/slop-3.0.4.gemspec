# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{slop}
  s.version = "3.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Lee Jarvis}]
  s.date = %q{2012-01-31}
  s.description = %q{A simple DSL for gathering options and parsing the command line}
  s.email = %q{lee@jarvis.co}
  s.homepage = %q{http://github.com/injekt/slop}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Option gathering made easy}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
