//
//  StringExt.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/30/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
extension String {
    
    static func MD5(_ string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let d = string.data(using: String.Encoding.utf8) {
           _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    
    func removeString(string: String) -> String {
        return self.replacingOccurrences(of: string, with: "")
    }
    
    static func jsonStringFrom(dictionary : [String : String]) -> String {
        
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        }
        catch {
            return ""
        }
        
   
    }
}
