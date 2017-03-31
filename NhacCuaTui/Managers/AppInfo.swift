//
//  AppInfo.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/30/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

struct AppInfo {
    static let shared = AppInfo()
    
    var user : NCTUser?
    let deviceInfo = DeviceInfo()
    var jsonString : String {
        get {
            
            var dic : [String : String] = Dictionary<String, String>()
            dic.updateValue(self.deviceInfo.deviceID, forKey: "DeviceID")
            dic.updateValue(self.deviceInfo.os, forKey: "OsName")
            dic.updateValue(self.deviceInfo.osVersion, forKey: "OsVersion")
            dic.updateValue(self.deviceInfo.appName, forKey: "AppName")
            dic.updateValue(self.deviceInfo.appVersion, forKey: "AppVersion")
            dic.updateValue(self.user != nil ? self.user!.userName : "", forKey: "UserName")
            dic.updateValue("", forKey: "LocationInfo")
            dic.updateValue("0", forKey: "Adv")
            
            return String.jsonStringFrom(dictionary: dic)
        }
    }
    private init() {
    
    }
    
    
    internal struct DeviceInfo {
        let deviceID = UIDevice.current.identifierForVendor != nil ? String.MD5(UIDevice.current.identifierForVendor!.uuidString) : ""
        let os = "TVOS"
        let osVersion = UIDevice.current.systemVersion
        let appName = "NhacCuaTuiTV"
        let appVersion = Bundle.main.infoDictionary != nil ? Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String : ""
        let model = UIDevice.current.model
        
    }
}



