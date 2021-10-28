

This is a react-native template which include 3 main dependency:
 - [react-native-navigation](https://wix.github.io/react-native-navigation/docs/before-you-start/)
   - Native navigation for react native
 - [react-native-config](https://github.com/luggit/react-native-config)
   - Config all the Environment Variable incldue JS side and native code side
 - [react-native-splash-screen](https://github.com/crazycodeboy/react-native-splash-screen)
   - Launch screen control

 <br> 


# 1. Prepare environment and installing react native dependencies

### You will need Node, Watchman, the React Native command line interface, Xcode and CocoaPods.
### While you can use any editor of your choice to develop your app, you will need to install Xcode in order to set up the necessary tooling to build your React Native app for iOS.
 <br>

## Node & Watchman

### We recommend installing Node and Watchman using Homebrew. Run the following commands in a Terminal after installing Homebrew:

```sh
> brew install node  
> brew install watchman
```

<br>

### If you have already installed Node on your system, make sure it is Node 12 or newer.
### Watchman is a tool by Facebook for watching changes in the filesystem. It is highly recommended you install it for better performance.
 <br>


## Xcode
### The easiest way to install Xcode is via the Mac App Store. Installing Xcode will also install the iOS Simulator and all the necessary tools to build your iOS app.
### If you have already installed Xcode on your system, make sure it is version 10 or newer.
 <br>

## Command Line Tools
### You will also need to install the Xcode Command Line Tools. Open Xcode, then choose "Preferences..." from the Xcode menu. Go to the Locations panel and install the tools by selecting the most recent version in the Command Line Tools dropdown.
![Alt text](https://reactnative.dev/assets/images/GettingStartedXcodeCommandLineTools-8259be8d3ab8575bec2b71988163c850.png)
<br>

## CocoaPods
### CocoaPods is built with Ruby and it will be installable with the default Ruby available on macOS. You can use a Ruby Version manager, however we recommend that you use the standard Ruby available on macOS unless you know what you're doing.
### Using the default Ruby install will require you to use sudo when installing gems. (This is only an issue for the duration of the gem installation, though.)
```sh
sudo gem install cocoapods
```
<br>

### For more information, please visit [CocoaPods Getting Started guide](https://guides.cocoapods.org/using/getting-started.html).
<br>


# 2. Install project dependency and rename project
```sh
> git clone https://github.com/migounetwork/SDKExample.git SDKExample
> cd SDKExample
> sudo npm install -g yarn
> yarn install
> npx react-native-rename "新包名"
> pod install --project-directory=ios
```
> 注意：新包名会统一替换file、folder以及源码内容，才不会都以SDExample做路径和档名。跑完请重载xcode，如果已安装pod，需要再重新跑pod install才能顺利运行。

<br>
<br>


# 3. Config global variable
### Please add global variables by `.env.production` file. Those variable could be use in Info plist for define your app bundle_id, version number, version code, app name and `白包 view controller name` which define in the `AppDelegate.m`.
```sh
# .env.production

export APP_ID_IOS="com.sdkExample"
export APP_NAME="SDK Example"
export IOS_VER_CODE="1"
export IOS_VER_MAJOR="1.0"
export EXT_NAME="我的外部新包" ## 白包view controller name
```
> 注意：
> 1. .env.production是隐藏文档，你先开启macos隐藏文档才能在xcode里看到。
> 2. 不要用Xcode改变app名和bundle identifier包括版号，请一律使用 `.env.production` 来设置
> 3. 设置完后，每次run/build/archive都会自动引入到Info.plist
<br>

# 4. Unpack SDK bundle
### We will have all the control logic in javascript which will be bundle to a `sdk.tar.gz` zip file and place it to the project root folder.
### The SDK zip will be unzip and integrage to build folder before running on simulator or archive to ipa when you run/archive this project in xCode (refer `xcode -> build phases`).
> 注意： 请确认在run/archive前， `sdk.tar.gz` 已经备妥并有放置在Project根目录. 

<br>

# 5. Run your project
### Please run in simulator or archive to ipa for submit after `.env.projection` and `sdk.tar.gz` is ready.

<br>

# 6. Add custom native modulel
### The ExternalComponent layout allows you to display any native view as a screen. To use the External Component we'll need to register it with a string name. This name is then used when declaring layouts in JS.

<br>

## ViewController registration
### Import your custom view controller to `ios/rnnexample/AppDelegate.m`
```objc
#import "RNNCustomViewController.h"
```
### Register constom view controller in `ios/rnnexample/AppDelegate.m` as a specific register name `RNNCustomComponent`
```objc
RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
[ReactNativeNavigation bootstrapWithBridge:bridge];
[ReactNativeNavigation registerExternalComponent:@"我的外部新包" callback:^UIViewController *(NSDictionary *props, RCTBridge *bridge) {
    return [[RNNCustomViewController alloc] initWithProps:props];
}];
```
### Setup registered component name `RNNCustomComponent` to the first entry point in `.env.production`:
```sh
export EXT_NAME="我的外部新包" ## 白包view controller name
```

> 注意：`RNNCustomViewController.h` 是事先准备好的白包示例，请在`AppDelegate.m` 替换成其它白包的view controller
