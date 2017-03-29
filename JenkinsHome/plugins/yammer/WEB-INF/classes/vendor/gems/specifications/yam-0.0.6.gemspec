# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yam}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Yammer team at thoughtbot}]
  s.date = %q{2013-01-29}
  s.description = %q{The official Yammer Ruby gem.}
  s.email = [%q{yammer@thoughtbot.com}]
  s.homepage = %q{https://github.com/yammer/yam}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{A Ruby wrapper for the Yammer REST API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.8.1"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<json>, ["~> 1.7.6"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_runtime_dependency(%q<oauth2>, ["~> 0.8.0"])
      s.add_development_dependency(%q<bourne>, ["~> 1.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.8"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7.1"])
      s.add_development_dependency(%q<webmock>, ["~> 1.9.0"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.8.1"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
      s.add_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_dependency(%q<json>, ["~> 1.7.6"])
      s.add_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_dependency(%q<oauth2>, ["~> 0.8.0"])
      s.add_dependency(%q<bourne>, ["~> 1.0"])
      s.add_dependency(%q<mocha>, ["~> 0.9.8"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
      s.add_dependency(%q<webmock>, ["~> 1.9.0"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.8.1"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
    s.add_dependency(%q<hashie>, ["~> 1.2.0"])
    s.add_dependency(%q<json>, ["~> 1.7.6"])
    s.add_dependency(%q<multi_json>, ["~> 1.3"])
    s.add_dependency(%q<oauth2>, ["~> 0.8.0"])
    s.add_dependency(%q<bourne>, ["~> 1.0"])
    s.add_dependency(%q<mocha>, ["~> 0.9.8"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
    s.add_dependency(%q<webmock>, ["~> 1.9.0"])
  end
end
