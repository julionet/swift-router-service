Pod::Spec.new do |spec|
    spec.name = 'SwiftRouterService'
    spec.version = '1.0.0'
    spec.summary = 'Swift router service'
    spec.description = 'Swift router service description'

    spec.homepage = 'https://github.com/julionet/swift-router-service'
    spec.license = { :type => 'MIT', :file => 'LICENSE' }
    spec.author = { 'Jose Julio' => 'julio.net@gmail.com' }
    spec.source = { 
        :git => 'https://bancopan.visualstudio.com/banco-digital/_git/mobile-ios--bdrouter-service', 
        :branch => 'master',
        :tag => spec.version.to_s
    }

    spec.ios.deployment_target = '15.0'
    spec.swift_version = '5.0' if spec.respond_to?(:swift_version)

    spec.subspec 'Release' do |release|
        release.source_files = "Sources/**/*.swift"
        #release.dependency 'SLNotificationServiceInterface'
        release.frameworks = 'UIKit'
    end
end
