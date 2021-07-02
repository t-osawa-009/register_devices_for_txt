import Foundation
import Commander
import Files

let main = command(
    Option<String>("devices_txt_path", default: ".", description: "File path of devices.txt"),
    Option<String>("device_id", default: "", description: "Device id to register"),
    Option<String>("device_name", default: "", description: "Device name to register"),
    Option<String>("device_platform", default: "ios", description: "The platform of the device to register.")
) { (devices_txt_path, device_id, device_name, device_platform) in
    print("start")
    guard !device_id.isEmpty else {
        print("device_id is empty")
        return
    }
    
    guard !device_name.isEmpty else {
        print("device_name is empty")
        return
    }
    
    do {
        let devicesTxt = try DevicesTxt(path: devices_txt_path)
        try devicesTxt.add(deviceId: device_id, deviceName: device_name, devicePlatform: device_platform)
        print("Success!!")
    } catch {
        print("Failure !!")
        print(error.localizedDescription)
    }
}

enum RegisterError: Error {
    case duplicate
}

final class DevicesTxt {
    let raw: String
    private var path: String
    private var rawArray: [String]
    private var ids: [String] = []
    private var names: [String] = []
    init(path: String) throws {
        self.path = path
        let folder = try Folder(path: path)
        let file = try folder.file(named: "devices.txt")
        self.raw = try file.readAsString()
        let _rawArray = raw.components(separatedBy: "\n").dropFirst()
        self.rawArray = _rawArray.map({ $0 })
        self.rawArray.forEach { text in
            let array = text.components(separatedBy: "\t")
            if let id = array.first {
                ids.append(id)
            }
            
            if array.count >= 2 {
                let name = array[1]
                names.append(name)
            }
        }
    }
    
    func add(deviceId: String, deviceName: String, devicePlatform: String) throws {
        guard !ids.contains(deviceId) else {
            print("The same id exists. \(deviceId)")
            throw RegisterError.duplicate
        }
        
        guard !names.contains(deviceName) else {
            print("The same device name exists. \(deviceName)")
            throw RegisterError.duplicate
        }
        
        let tabStr = "\t"
        let newDeviceStr = "\(deviceId)" + tabStr + "\(deviceName)" + tabStr + "\(devicePlatform)"
        let newStr = self.raw.trimmingCharacters(in: .whitespacesAndNewlines) + "\n" + newDeviceStr
        
        let folder = try Folder(path: path)
        let file = try folder.file(named: "devices.txt")
        try file.write(newStr)
    }
}

main.run("0.0.1")
