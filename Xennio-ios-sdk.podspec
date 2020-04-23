Pod::Spec.new do |spec|

  spec.name          = "Xennio-ios-sdk"
  spec.version       = "1.1"
  spec.swift_version = "5.1"
  spec.summary       = "Xennio unified engine IOS SDK"
  spec.description   = "Xennio unified engine official IOS SDK"
  spec.platform      = :ios, '8.0'
  spec.homepage      = "https://xenn.io"
  spec.license       = "MIT"
  spec.author        = { "Yildirim Adiguzel" => "yildirim@xenn.io" }
  spec.source        = { :git => "https://github.com/xennio/harray-ios-sdk" }
  spec.source_files  = "harray-ios-sdk/**/*"
end