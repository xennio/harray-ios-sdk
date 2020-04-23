Pod::Spec.new do |spec|

  spec.name          = "Xennio-ios-sdk"
  spec.version       = "1.1"
  spec.swift_version = "5.1"
  spec.summary       = "Xennio unified engine IOS SDK"
  spec.description   = "Xennio unified engine official IOS SDK"
  spec.platform      = :ios, '8.0'
  spec.ios.deployment_target = "12.1"
  spec.homepage      = "https://github.com/xennio/harray-ios-sdk"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "Yildirim Adiguzel" => "yildirim@xenn.io" }
  spec.source        = { :git => "https://github.com/xennio/harray-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "harray-ios-sdk/**/*.{h,m,swift}"
end