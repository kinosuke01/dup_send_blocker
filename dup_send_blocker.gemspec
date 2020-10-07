$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dup_send_blocker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dup_send_blocker"
  s.version     = DupSendBlocker::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "https://pepabo.com/"
  s.summary     = "This gem blocks duplicate emails."
  s.description = "This gem blocks duplicate emails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.11.3"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "pry-rails"
end
