# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{httpauth}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Manfred Stienstra}]
  s.date = %q{2012-09-25}
  s.description = %q{Library for the HTTP Authentication protocol (RFC 2617)}
  s.email = %q{manfred@fngtpspec.com}
  s.extra_rdoc_files = [%q{README.md}, %q{LICENSE}]
  s.files = [%q{README.md}, %q{LICENSE}]
  s.homepage = %q{https://github.com/Manfred/HTTPauth}
  s.rdoc_options = [%q{--charset=utf-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{HTTPauth is a library supporting the full HTTP Authentication protocol as specified in RFC 2617; both Digest Authentication and Basic Authentication.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
