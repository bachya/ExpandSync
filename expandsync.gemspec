# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expandsync/constants'

Gem::Specification.new do |spec|
  spec.name             = 'expandsync'
  spec.version          = ExpandSync::VERSION
  spec.authors          = ['Aaron Bach']
  spec.email            = ['bachya1208@googlemail.com']
  spec.summary          = ExpandSync::SUMMARY
  spec.description      = ExpandSync::DESCRIPTION
  spec.homepage         = 'https://github.com/bachya/ExpandSync'
  spec.license          = 'MIT'
  spec.platform         = Gem::Platform::RUBY

  spec.require_paths    = ["lib"]
  spec.files            = `git ls-files -z`.split("\x0")
  spec.executables      = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  
  spec.license          = 'MIT'
  spec.rdoc_options     = ['--charset=UTF-8']
  spec.extra_rdoc_files = %w[README.md HISTORY.md LICENSE]

  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('aruba', '~> 0')
  spec.add_dependency('methadone', '~> 1.3', '>= 1.3.1')
  spec.add_dependency('nokogiri', '~> 1.6', '>= 1.6.1')
end
