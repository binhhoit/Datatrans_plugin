#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint datatrans_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'datatrans_plugin_flutter'
  s.version          = '1.0.0'
  s.summary          = 'A new Datatrans Flutter plugin project.'
  s.description      = <<-DESC
A new Datatrans Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.static_framework = true
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Alamofire'
  s.dependency 'Datatrans'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
