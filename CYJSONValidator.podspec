Pod::Spec.new do |spec|
  spec.name         = 'CYJSONValidator'
  spec.version      = '0.1'
  spec.authors      = 'Jason li'
  spec.homepage     = 'http://blog.csdn.net/lihei12345'
  spec.source       = { :git => 'https://github.com/lihei12345/CYJSONValidator.git', :tag => "#{spec.version}"}
  spec.license      = {
      :type => 'Copyright',
      :text => <<-LICENSE
      Copyright 2014 Jason. All rights reserved.
      LICENSE
  }
  spec.summary      = 'A simple and safe wrapper for RPJSONValidator on iOS JSON data parsing '
  spec.source_files = 'CYJSONValidatorDemo/Class/*.{h,m}'
  spec.platform     = :ios
  spec.framework    = 'AdSupport', 'Security'
  spec.requires_arc = true
  spec.ios.deployment_target = '6.0'
  spec.dependency 'RPJSONValidator', '~> 0.2.0'
end