Pod::Spec.new do |s|
  s.name                      = "AppleAuthenticationWrapper"
  s.version                   = "1.0.0"
  s.summary                   = "AppleAuthenticationWrapper"
  s.homepage                  = "https://github.com/moslienko/AppleAuthenticationWrapper"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Pavel Moslienko" => "8676976+moslienko@users.noreply.github.com" }
  s.source                    = { :git => "https://github.com/moslienko/AppleAuthenticationWrapper.git", :tag => s.version.to_s }
  s.swift_version             = "5.1"
  s.ios.deployment_target     = "13.0"
  s.source_files              = "Sources/**/*"
  s.frameworks                = "Foundation"
end
