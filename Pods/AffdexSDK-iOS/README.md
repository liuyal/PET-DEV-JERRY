![Affectiva Logo](https://developer.affectiva.com/wp-content/uploads/sites/2/2017/11/logo.png)

## Affdex SDK for iOS v4.0.1

#### Copyright (c) 2017 Affectiva Inc.<br/>See our [SDK License Agreement](http://developer.affectiva.com/sdklicense) for copying permission.

Welcome to the Affdex SDK for iOS.

We are surrounded by highly-connected smart devices, interactive digital experiences and artificial intelligence. Yet, technology is not able to sense, analyze and adapt to human emotions. At Affectiva, we have made it our mission to bring emotional intelligence to the digital world. To make this mission a reality, we have created the Affdex SDK so that others can bring emotion sensing and analytics to their own offerings, be it digital experiences, apps, games, devices, or other technologies.

Using our SDK, developers can now enrich digital experiences and apps by detecting emotion. Devices can now instantly respond to a user’s unfiltered emotions, and apps can adjust their interfaces and flow to better suit moods. This makes for a more authentic, interactive, and unique experience.

For developer documentation, sample code, and other information, please visit our website:
http://developer.affectiva.com

The SDK License Agreement is available at:
http://developer.affectiva.com/sdklicense

## Getting started

__The Affdex SDK for iOS is distributed with [CocoaPods](https://cocoapods.org/pods/AffdexSDK-iOS) and [Carthage](https://github.com/Carthage/Carthage).__

### __CocoaPods__
If you do not have CocoaPods installed on your Mac, please install it using the instructions in the [CocoaPods Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html).

#### 1. Create a Podfile

After you have installed CocoaPods on your Mac, create a file named "Podfile" in your project directory.  This is the directory which contains the .xcodeproj and/or .xcworkspace files for your project.  The Podfile is a plain-text file which describes the framework and library dependencies that your project contains.  Installing the pod file will load and configure the Affdex SDK framework for use with your project.

Place the following text into your Podfile, substituting your app name for the 'MyApp' target:

```
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target 'MyApp' do
    pod 'AffdexSDK-iOS'
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
```

*Note: The post_install step is required in order to configure the AWS subdependencies of the Affdex SDK (the 'AWSCore' and 'AWSKinesis' targets) if your app supports bitcode.  If you do not require bitcode support in your app, this section can be omitted from the Podfile.*

#### 2. Install the Affdex SDK CocoaPod

With the Podfile created, run the following commands from the Terminal application:

```
pod repo update
pod install
```

This will install the SDK and support pods into the Pods folder, and will create or update the Xcode workspace file to support building from the pods.  Make sure to open the .xcworkspace file in Xcode instead of the .xcodeproj file from this point onwards.  You can now build and run the project to a device or simulator from Xcode.

After you run `pod install` your app will be linked to the most recent release of the Affdex SDK, although you can also configure your Podfile to install a specific version of the SDK if you choose.  Your project will continue to use this version even if newer versions of the SDK are released.  Use the `pod update` command to update to newer SDK releases as they become available.

----

### __Carthage__
If you do not have Carthage installed on your Mac, please install it using the instructions in [Installing Carthage](https://github.com/Carthage/Carthage#installing-carthage)

#### 1. Create a Cartfile
After you have installed Carthage on your Mac, create a file named "Cartfile" in your project directory.  This is the directory which contains the .xcodeproj and/or .xcworkspace files for your project. The Cartfile is a plain-text file which describes the framework and library dependencies that your project contains. Carthage will use this file to fetch and build your dependencies if needed.

- Add the following to your Cartfile:

```
binary "https://download.affectiva.com/apple/ios/AffdexSDK.json" ~> 4.0.1
github "aws/aws-sdk-ios"
```

#### 2. Install the AffdexSDK

- Run `carthage update`. This will fetch dependencies into a Carthage/Checkouts folder, then build each one or download a pre-compiled framework.

- On your application targets’ __“General”__ settings tab, in the __“Linked Frameworks and Libraries”__ section, drag and drop the following frameworks from the Carthage/Build folder on disk:


```
Affdex.framework
AWSCore.framework
AWSKinesis.framework
```

- On your application targets’ __“Build Phases”__ settings tab, click the “+” icon and choose __“New Run Script Phase”__. Create a Run Script in which you specify your shell (ex: /bin/sh), add the following contents to the script area below the shell:

```
carthage copy-frameworks
```

- Add the paths to the frameworks the under “Input Files”:

```
$(SRCROOT)/Carthage/Build/iOS/Affdex.framework
$(SRCROOT)/Carthage/Build/iOS/AWSCore.framework
$(SRCROOT)/Carthage/Build/iOS/AWSKinesis.framework
```

- Add the paths to the copied frameworks to the “Output Files”:

```
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Affdex.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/AWSCore.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/AWSKinesis.framework
```
