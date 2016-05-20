Pod::Spec.new do |s|
  s.name         = "Tactile"
  s.version      = "1.2.2"
  s.license      = { :type => "MIT" }
  s.homepage     = "https://github.com/delba/Tactile"
  s.author       = { "Damien" => "damien@delba.io" }
  s.summary      = "A better way to handle gestures and control events"
  s.source       = { :git => "https://github.com/delba/Tactile.git", :tag => "v1.2.2"  }

  s.ios.deployment_target = "8.0"

  s.source_files = "Source/**/*"

  s.requires_arc = true
end
