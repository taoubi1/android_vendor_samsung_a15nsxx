#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):83886080:fdca9de5de51297dcf541d4e4c250d4ecef99d58; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):67108864:891796e79740224df016e39f66fb7eabd36e13d8 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):83886080:fdca9de5de51297dcf541d4e4c250d4ecef99d58 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

