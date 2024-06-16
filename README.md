## Setup environment 

```  bash
sudo apt update && sudo apt install default-jdk -y
unzip Emulator-CLI-Autocompleter-master.zip
cd Emulator-CLI-Autocompleter-master
unzip commandlinetools-linux-6609375_latest.zip
mkdir ../cmdline-tools
mv tools ../cmdline-tools
```

# Setup ~/.bashrc

```text
export ANDROID_HOME=/home/ubuntu/appium-qemu-noKVM
export ANDROID_SDK_ROOT=/home/ubuntu/appium-qemu-noKVM/cmdline-tools/latest
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin
```

```  bash
source ~/.bashrc
```

## Configure and set up the emulator

```  bash
sdkmanager --licenses
sdkmanager "emulator"
sdkmanager "platform-tools"
sdkmanager "system-images;android-25;google_apis;armeabi-v7a"
echo "no" | avdmanager create avd --name "testDevice" -k "system-images;android-25;google_apis;armeabi-v7a"
sdkmanager --install "cmdline-tools;latest"
```

## Run start_emulator.sh
```  bash
chmod a+X start_emulator.sh 
chmod 755 start_emulator.sh 
./start_emulator.sh 
```

## Configure appium
- Install Node.js (using NodeSource repository) and npm

```  bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
  && sudo apt-get install -y nodejs
```

- Verify Node.js and npm versions
```  bash
node -v
npm -v
```

- Install appium
```  bash
sudo npm install -g appium@2.4.1 appium-uiautomator2-driver@2.10.0
appium driver install uiautomator2
```

- Install dependencies
```  bash

adb -s emulator-5554 uninstall io.appium.settings

adb -s emulator-5554 install -g /home/ubuntu/.appium/node_modules/appium-uiautomator2-driver/node_modules/io.appium.settings/apks/settings_apk-debug.apk

adb -s emulator-5554 install -r /home/ubuntu/.appium/node_modules/appium-uiautomator2-driver/node_modules/appium-uiautomator2-server/apks/appium-uiautomator2-server-v7.0.10.apk

adb -s emulator-5554 install -r /home/ubuntu/.appium/node_modules/appium-uiautomator2-driver/node_modules/appium-uiautomator2-server/apks/appium-uiautomator2-server-debug-androidTest.apk

```


## Open Ports AWS EC2.
- 4723


## Appium run
```bash
sudo npm install -g appium-doctor
appium-doctor --android
appium server --allow-cors --relaxed-security
```


## Inspector
- Connection 
    ```text
    Remote Path: /
    Remote Port: 4723
    Remote Host: ip
    ```

- Capabilities
```json
{
  "platformName": "Android",
  "appium:deviceName": "emulator-5554",
  "appium:automationName": "UiAutomator2",
  "appium:newCommandTimeout": 3600
}
```


## Install apps
```bash
adb -s emulator-5554 install  /home/ubuntu/appium-qemu-noKVM/apps/DeviceInfo.apk
```