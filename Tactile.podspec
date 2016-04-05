#
#  Be sure to run `pod spec lint Tactile.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Tactile"
  s.version      = "1.2"
  s.license      = { :type => "MIT" }
  s.homepage     = "https://github.com/delba/Tactile"
  s.author       = { "Damien Delba" => "damien@delba.io" }
  s.summary      = "A better way to handle gestures and control events"
  s.source       = { :git => "https://github.com/delba/Tactile.git", :tag => "v1.2"  }

  s.ios.deployment_target = "8.0"

  s.source_files = "Source/*.swift"

  s.requires_arc = true
end
