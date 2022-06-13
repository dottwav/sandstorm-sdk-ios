Pod::Spec.new do |s|

    s.name              = 'SandstormLiteSDK'
    s.version           = '1.0.5'
    s.summary           = 'All-you-need SDK for your in-app audio advertisement'
    s.homepage          = 'https://www.adtonos.com'
    s.authors           = { 'Mateusz Wojnar' => 'mateusz.wojnar@siroccomobile.com', 'Aleksander Olszewski' => 'aleksander.olszewski@siroccomobile.com' }
    s.license           = { :type => 'Proprietary', :file => 'LICENSE.txt' }
    s.platform          = :ios
    s.source            = { :git => 'https://github.com/adtonos/sandstorm-sdk-ios.git', :tag => s.version }
    s.swift_version = '5.0'
    s.ios.deployment_target = '10.0'
    s.ios.vendored_frameworks = 'SandstormLiteSDK.xcframework'

    s.dependency 'GoogleAds-IMA-iOS-SDK', '3.14.3'
    s.dependency 'ThunderLiteSDK', '1.0.5'

    s.static_framework = true
    s.user_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }

end
