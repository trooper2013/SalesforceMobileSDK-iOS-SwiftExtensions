platform :ios, '10.0'

project 'Test2.xcodeproj'
target 'Test2' do

source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

# NB: get rid of next line once FMDB works with xcode 9
pod 'FMDB', :git => 'https://github.com/forcedotcom/fmdb', :branch => '2.7.2_xcode9'
pod 'PromiseKit', '~> 4.4'
pod 'SalesforceAnalytics', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SalesforceSDKCore', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SmartStore', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'
pod 'SmartSync', :path => 'mobile_sdk/SalesforceMobileSDK-iOS'

end
