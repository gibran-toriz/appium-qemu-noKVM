

echo "Starting..."

pkill -f emulator

# Restart the ADB server
adb kill-server
adb start-server
# Check if any devices are connected
adb devices

# Download the necessary system image
sdkmanager "system-images;android-25;google_apis;armeabi-v7a"

# Delete and recreate the AVD
avdmanager delete avd --name testDevice
echo "no" | avdmanager create avd --name "testDevice" -k "system-images;android-25;google_apis;armeabi-v7a" -d "pixel"

# Start the emulator in the background with increased memory
nohup emulator -ports 5554,5555 -avd testDevice -writable-system -no-window -no-audio -gpu swiftshader_indirect -show-kernel -memory 2048 -verbose > emulator.log 2>&1 &

# Wait for the emulator to boot
echo "Waiting for the emulator to boot..."
while true; do
    boot_status=$(adb -s emulator-5554 shell getprop init.svc.bootanim | tr -d '\r')
    if [ "$boot_status" == "stopped" ]; then
        echo "Emulator has finished booting."
        break
    elif [ "$boot_status" == "running" ]; then
        echo "Emulator is running."
        break
    elif [ "$boot_status" == "device offline" ]; then
        echo "Device is offline, waiting..."
    else
        echo "Boot status: $boot_status, waiting..."
    fi
    sleep 5
done


# Verify the emulator is recognized by ADB
if adb devices | grep -q "emulator-5554"; then
    echo "Emulator is ready."
else
    echo "Emulator failed to start."
    exit 1
fi

# Disable SELinux (for testing)
adb -s emulator-5554 shell su 0 setenforce 0

# # Monitor logs
# adb -s emulator-5554 logcat
