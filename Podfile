# Uncomment the next line to define a global platform for your project
# platform :ios, ’11.0’

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target 'PET' do

  # Pods for PET

  pod 'AffdexSDK-iOS'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'    

  pod 'Hero'
  pod 'Charts'
  pod 'FontAwesome.swift'
  pod 'SnapKit', '~> 4.0.0'
  pod 'PopupDialog', '~> 0.6'
  pod 'UICircularProgressRing'
  pod 'SkyFloatingLabelTextField'
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if (target.name == "AWSCore") || (target.name == 'AWSKinesis')
            target.build_configurations.each do |config|
                config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
            end
        end
    end
end
