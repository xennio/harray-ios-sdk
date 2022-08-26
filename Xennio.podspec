Pod::Spec.new do |spec|

  spec.name          = "Xennio"
  spec.version       = "2.5.21"
  spec.swift_version = "4.2"
  spec.summary       = "Xennio unified engine IOS SDK"
  spec.description   = "Xennio unified engine official IOS SDK"
  spec.platform      = :ios, '8.0'
  spec.ios.deployment_target = "10.0"
  spec.homepage      = "https://github.com/xennio/harray-ios-sdk"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "Xennio Development Team" => "developer@xenn.io" }
  spec.source        = { :git => "https://github.com/xennio/harray-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "harray-ios-sdk/**/*.{h,m,swift,xib}"
  spec.resources = ['harray-ios-sdk/**/*.png']
end
