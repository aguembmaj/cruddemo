# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

# ignore all warnings from all dependencies
inhibit_all_warnings!
# ignore warnings from a specific dependency
#pod 'FBSDKCoreKit', :inhibit_warnings => true

def base_pods
  pod 'Alamofire'
end

target 'CRUDDemo' do
  base_pods
end


post_install do |installer|
installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
end
end


