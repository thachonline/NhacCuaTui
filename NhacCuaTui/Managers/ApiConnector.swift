//
//  ApiConnector.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/30/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import Alamofire
class ApiConnector {
//    #define kAPI_SUCCESS            0
//    
//    #define kAPI_INVALID_REQUEST    201
//    #define kAPI_SYSTEM_ERROR       202
//    #define kAPI_ACCESS_DENIE       208
//    
//    #define kAPI_USER_NOT_LOGIN     203
//    #define kAPI_USER_NOT_EXIST     204
//    #define kAPI_USER_LOCKED        205
//    
//    #define kAPI_DATA_EMPTY         200
//    #define kAPI_DATA_NOT_EXIST     201
//    
//    #define kAPI_EMPTY_TOKEN                  110
//    #define kAPI_INVALID_TOKEN                111
//    #define kAPI_EXPIRED_TOKEN                112
//    #define kAPI_NOT_EXIST_TOKEN              113
//    #define kAPI_WRITE_FAILD_TOKEN            114
//    #define kAPI_TIMESTAMP_INVALID_TOKEN      115
    
    
    private let SECRET_KEY = "#syntcjd!@3d^ff"
    private let BASE_URL = "https://graph.nhaccuatui.com/v1/"
    private var accessToken = ""
    
    private let URL_ACCESS_TOKEN = "commons/token"
    private let URL_HOME_DATA = "commons/home"
    private let URL_GENRE = "videos/genre/%d"
    
    
    static let shared = ApiConnector()
    private init(){
    }
    
    
    private func getAccessToken(completionBlock:@escaping () -> (), errorBlock:@escaping (_ errorCode: Int? ) -> ()){
        //?deviceinfo=%@&timestamp=%lf&md5=%@
        let utilityQueue = DispatchQueue.global(qos: .utility)
        let deviceInfoJson = AppInfo.shared.jsonString
        let timeStamp = CUnsignedLongLong(Date.timeIntervalSinceReferenceDate * 1000)
        let md5 = String.MD5("\(SECRET_KEY)\(timeStamp)\(AppInfo.shared.deviceInfo.deviceID)")
        let params:[String:Any] = [
            "deviceinfo" : deviceInfoJson,
            "timestamp" : timeStamp,
            "md5" : md5
        ]
        Alamofire.request("\(BASE_URL)\(URL_ACCESS_TOKEN)", method: .post, parameters: params).responseJSON(queue: utilityQueue) { [unowned self] (response) in
            
            
            switch response.result {
            case .success(let json):
                guard let responseDic = json as? [String: Any] else {
                    errorBlock(-1)
                    return
                }
                
                guard let tokenData = responseDic["data"] as? [String: Any] else {
                    errorBlock(-1)
                    return
                }
                
                guard let token = tokenData["accessToken"] as? String else {
                    errorBlock(-1)
                    return
                }
                
                self.accessToken = token
                
                completionBlock()
                break
            case .failure(let error):
                print(error.localizedDescription)
                if let httpStatusCode = response.response?.statusCode {
                    errorBlock(httpStatusCode)
                } else {
                    errorBlock(-1)
                }
                break
            }
            
           
            
        }
    }
    
    
    func getHomeData(completionBlock:@escaping () -> (), errorBlock:@escaping (_ errorCode: Int? ) -> ()) {
        //commons/home?access_token={0}
        let utilityQueue = DispatchQueue.global(qos: .utility)
        let params: [String:Any] = [
            "access_token" : self.accessToken
        ]
//        
        Alamofire.request("\(self.BASE_URL)\(self.URL_HOME_DATA)", method: .get, parameters: params).responseJSON(queue: utilityQueue) {[unowned self]   (response) in
            switch response.result {
            case .success(let json):
                guard let responseData = APIResponseData(response: response.response, representation: json) else {
                    errorBlock(-1)
                    break
                }
                
                if responseData.responseCode != 0 {
                    //retrieve access_token
                    self.getAccessToken(completionBlock: { 
                        // retry fectching home data
                        self.getHomeData(completionBlock: { 
                            
                        }, errorBlock: { (errorCode) in
                            errorBlock(errorCode)
                        })
                    }, errorBlock: { (errorCode) in
                        errorBlock(errorCode)
                    })
                }
                else {
                    // completion
                    
                    // parse data to entities
                    print(responseData)
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                if let httpStatusCode = response.response?.statusCode {
                    errorBlock(httpStatusCode)
                } else {
                    errorBlock(-1)
                }
                break
            }
        }
        
        
        
    }
}
