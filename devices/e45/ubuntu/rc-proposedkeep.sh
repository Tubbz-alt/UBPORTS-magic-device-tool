clear
echo ""
echo "Flashing rc-proposed channel"
echo ""
sleep 1
echo "Please boot your E4.5 into bootloader/fastboot mode by pressing Power & Volume Up (+)"
echo "and select fastboot mode"
echo ""
sleep 1
echo -n "Is your E4.5 in bootloader/fastboot mode now? [Y] "; read bootloadermode
if [ "$bootloadermode"==Y -o "$bootloadermode"==y -o "$bootloadermode"=="" ]; then
  clear
  echo ""
  echo "Detecting device"
  echo ""
  sleep 1
  fastboot devices > /tmp/AttachedDevices
fi
  if grep 'device$\|fastboot$' /tmp/AttachedDevices
  then
    echo "Device detected !"
    sleep 1
    clear
    echo ""
    echo "Flashing rc-proposed channel"
    echo ""
    wget -c --quiet --show-progress --tries=10 -P $HOME/.cache/magic-device-tool/ http://mdt-files.com/downloads/magic-device-tool/recoverys/recovery-krillin.img
    echo ""
    sleep 1
    fastboot flash recovery $HOME/.cache/magic-device-tool/recovery-krillin.img
    sleep 1
    fastboot boot $HOME/.cache/magic-device-tool/recovery-krillin.img
    echo ""
    echo "Please wait, your device will reboot a few times"
    echo ""
    sleep 15
    adb reboot recovery
    sleep 30
    ubuntu-device-flash touch --channel ubuntu-touch/rc-proposed/bq-aquaris.en --device krillin
    sleep 1
    echo ""
    echo "Move to your device to finish the setup."
    sleep 1
    echo ""
    echo "Cleaning up.."
    rm -f /tmp/AttachedDevices
    #rm recovery-krillin.img
    echo ""
    sleep 1
    echo "Exiting script. Bye Bye"
    sleep 1
    exit
  else
    echo "Device not found"
    sleep 1
    rm -f /tmp/AttachedDevices
    echo ""
    echo "Back to menu"
    sleep 1
    . ./launcher.sh
  fi
