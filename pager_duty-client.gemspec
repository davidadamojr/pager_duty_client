# frozen_string_literal: true

require_relative "lib/pager_duty/client/version"

Gem::Specification.new do |spec|
  spec.name = "pager_duty-client"
  spec.version = PagerDuty::Client::VERSION
  spec.authors = ["David Adamo Jr."]
  spec.email = ["me@davidadamojr.com"]

  spec.summary = "PagerDuty client"
  spec.description = "PagerDuty client"
  spec.homepage = "https://github.com/davidadamojr/pager_duty-client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/davidadamojr/pager_duty-client"
  spec.metadata["changelog_uri"] = "https://github.com/davidadamojr/pager_duty-client/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "simplecov", "~> 0.21.2"
  spec.add_development_dependency "webmock", "~> 3.18.0"
  spec.add_runtime_dependency "httparty", "~> 0.17.3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
