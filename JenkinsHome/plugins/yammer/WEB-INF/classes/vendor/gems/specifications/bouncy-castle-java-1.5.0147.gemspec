# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bouncy-castle-java}
  s.version = "1.5.0147"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Hiroshi Nakamura}]
  s.date = %q{2013-03-12}
  s.description = %q{Gem redistribution of "Legion of the Bouncy Castle Java cryptography APIs" jars at http://www.bouncycastle.org/java.html}
  s.email = %q{nahi@ruby-lang.org}
  s.homepage = %q{http://github.com/jruby/jruby/tree/master/gems/bouncy-castle-java/}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{jruby-extras}
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Gem redistribution of Bouncy Castle jars}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
