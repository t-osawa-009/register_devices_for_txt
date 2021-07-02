# register_devices_for_txt

fastlaneのdevices.txtを更新するコマンドラインツール

```txt
    --devices_txt_path [default: .] - File path of devices.txt
    --device_id [default: ] - Device id to register
    --device_name [default: ] - Device name to register
    --device_platform [default: ios] - The platform of the device to register.
```

## Installation
Mint

```
$ brew install mint
$ mint install t-osawa-009/register_devices_for_txt
```

## Usage

```
$ register_devices_for_txt --device_id A5B5CD50-14AB-5AF7-8B78-AB4751AB10A9 --device_name NAME3
```
