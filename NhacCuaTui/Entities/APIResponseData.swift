//
//  APIResponseData.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/31/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
struct APIResponseData: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {

    let data : Any
    let responseCode : Int
    
    var description: String {
        
        if let data = self.data as? [String:Any] {
            return data.description
        }
        
        return "\(self.responseCode)"
    }
    
    internal init?(response: HTTPURLResponse?, representation: Any) {
        guard
            let representation = representation as? [String: Any],
        let data = representation["data"] != nil ? representation["data"] : [] ,
            let responseCode = representation["code"] as? Int
            else { return nil }
        
        self.data = data
        self.responseCode = responseCode
        
    }
    
}
