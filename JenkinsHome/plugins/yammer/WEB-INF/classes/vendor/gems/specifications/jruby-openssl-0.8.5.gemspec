# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jruby-openssl}
  s.version = "0.8.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Ola Bini}, %q{JRuby contributors}]
  s.date = %q{2013-03-14}
  s.description = %q{JRuby-OpenSSL is an add-on gem for JRuby that emulates the Ruby OpenSSL native library.}
  s.email = %q{ola.bini@gmail.com}
  s.homepage = %q{https://github.com/jruby/jruby}
  s.require_paths = [%q{lib/shared}]
  s.rubyforge_project = %q{jruby/jruby}
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{OpenSSL add-on for JRuby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bouncy-castle-java>, [">= 1.5.0147"])
    else
      s.add_dependency(%q<bouncy-castle-java>, [">= 1.5.0147"])
    end
  else
    s.add_dependency(%q<bouncy-castle-java>, [">= 1.5.0147"])
  end
end
