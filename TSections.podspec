Pod::Spec.new do |s|
  s.name             = 'LibraryTemplate'
  s.version          = '0.0.1'
  s.summary          = 'TSections'
  s.description      = <<-DESC
  TSections description
                       DESC

  s.homepage         = 'https://github.com/kitaisreal/TSections'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kitaisreal' => 'kitaetoya@gmail.com' }
  s.source           = { :git => 'https://github.com/kitaisreal/TSections.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Sources/**/*.swift'
  s.swift_version = '5.0'
end
