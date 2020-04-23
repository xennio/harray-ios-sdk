Pod::Spec.new do |spec|

  spec.name         = "Xennio-ios-sdk"
  spec.version      = "1.1"
  s.swift_version   = "5.0"
  spec.summary      = "Xennio unified engine IOS SDK"
  spec.description  = "Xennio unified engine official IOS SDK"
  s.platform        = :ios, '8.0'
  spec.homepage     = "https://xenn.io"
  spec.license      = "MIT"
  spec.author       = { "Yildirim Adiguzel" => "yildirim@xenn.io" }
  spec.source       = { :git => "https://github.com/xennio/harray-ios-sdk" }
  spec.source_files  = "Pod/Classes/**/*"
end