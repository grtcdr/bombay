# frozen_string_literal: true

require_relative "lib/bombay/version"

Gem::Specification.new do |spec|
  spec.name = "bombay"
  spec.version = Bombay::VERSION
  spec.authors = ["grtcdr"]
  spec.email = ["ba.tahaaziz@gmail.com"]

  spec.summary = "Organize your $(pwd)."
  spec.homepage = "https://rubygems.org/gems/bombay"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/grtcdr/bombay"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "bin"
  spec.executables = ["bombay"]
  spec.require_paths = ["lib"]
end
