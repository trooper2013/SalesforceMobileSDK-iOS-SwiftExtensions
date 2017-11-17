//
//  SDKExtensions.swift
//  Test2
//
//  Created by Raj Rao on 11/4/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//
import Foundation
import SalesforceSDKCore
import PromiseKit

extension SalesforceSDKManager {
    
    func configure( config: (SFSDKAppConfig) -> Void ) -> SalesforceSDKManager {
        config(self.appConfig!)
        return self
    }
    
    func postLaunchBlock(action : @escaping SFSDKPostLaunchCallbackBlock) -> SalesforceSDKManager {
        self.postLaunchAction = action
        return self
    }
    
    func postLogoutBlock(action : @escaping SFSDKLogoutCallbackBlock) -> SalesforceSDKManager {
        self.postLogoutAction = action
        return self
    }
    
    func switchUserBlock(action : @escaping SFSDKSwitchUserCallbackBlock) -> SalesforceSDKManager {
        self.switchUserAction = action
        return self
    }
    
    func errorBlock(action : @escaping SFSDKLaunchErrorCallbackBlock) -> SalesforceSDKManager {
        self.launchErrorAction = action
        return self
    }
    
}

extension SFUserAccountManager  {
  
    var promiser: Promiser {
        return Promiser(api: self)
    }
    
    class Promiser {
        let api : SFUserAccountManager
        
        init(api: SFUserAccountManager) {
            self.api = api
        }
        
        func login() -> Promise<SFUserAccount> {
            return Promise<SFUserAccount> { fulfill, reject in
                api.login(completion: { (oauthInfo, userAccount) in
                    fulfill(userAccount)
                }, failure: { (oauthInfo, error) in
                    reject(error)
                })
            }
        }
        
        func logout() -> Promise<Bool> {
            return Promise<Bool> { fulfill, reject in
                let result   = true
                api.logout()
                fulfill(result)
            }
        }
    }
 
}

extension SFRestAPI  {
    
    var promises: Promises {
        return Promises(api: self)
    }

    
    class Promises {
        let api : SFRestAPI
        
        init(api: SFRestAPI) {
            self.api = api
        }
        
        // following helper methods for requestXX methods
        func requestVersions() -> Promise<SFRestRequest> {
            return Promise<SFRestRequest> { fulfill, reject in
                fulfill(api.requestForVersions())
            }
        }
        
        func send(request :SFRestRequest) -> Promise<Any> {
            return Promise<Any> { fulfill, reject in
                self.api.send(request, fail: { (error, urlResponse) in
                    reject(error!)
                }, complete: { (any, urlResponse) in
                    fulfill(any!)
                })
                
            }
        }
        
        func performSOSLSearch(query : String) -> Promise<Any> {
            return Promise<Any> { fulfill, reject in
                api.performSOSLSearch(query, fail: { (error, response) in
                    reject(error!)
                }, complete: { (any, response) in
                    fulfill(any!)
                })
            }
        }
        
        func performSOQLQuery(query : String) -> Promise<Any> {
            
            return Promise<Any> { fulfill, reject in
                api.performSOQLQuery(query, fail: { (error, response) in
                    reject(error!)
                }, complete: { (any, response) in
                    fulfill(any!)
                })
            }
        }
        
        func create(objectType : String,fields:[String:Any]) -> Promise<Any> {
            return Promise<Any> { fulfill, reject in
                api.performCreate(withObjectType: objectType, fields: fields, fail: { (error,response) in
                     reject(error!)
                }, complete: { (any, response) in
                     fulfill(any!)
                })
            }
        }
        
        func update(objectType : String, objectId: String, fields: [String:Any]) -> Promise<Any> {
            return Promise<Any> { fulfill, reject in
                api.performUpdate(withObjectType: objectType, objectId:objectId , fields: fields, fail: { (error,response) in
                    reject(error!)
                }, complete: { (any, response) in
                    fulfill(any!)
                })
            }
        }
        
        func delete(objectType : String, objectId: String) -> Promise<Any> {
            return Promise<Any> { fulfill, reject in
                api.performDelete(withObjectType: objectType, objectId: objectId, fail:{ (error,response) in
                    reject(error!)
                }, complete: { (any, response) in
                    fulfill(any!)
                })
            }
        }
        
        func retrieve(objectType : String, objectId: String, fields: [String]) -> Promise<Any> {
            return Promise<Any> { fulfill, reject in
                api.performRetrieve(withObjectType: objectType, objectId: objectId, fieldList: fields, fail:{ (error,response) in
                        reject(error!)
                    }, complete: { (any, response) in
                        fulfill(any!)
                })
            }
       }
       
    }
 
    // results parsing class functions
    static func parseResponseAsArray ( any : Any) -> Promise<[Dictionary<String, String>]> {
        return Promise<[Dictionary<String, String>]> { fulfill, reject in
            let rows =  (any as! [Dictionary<String, String>])
            return fulfill(rows)
        }
    }
    
    static func parseResponseAsJsonDictionary (any : Any) -> Promise<[Dictionary<String, Any>]> {
        return Promise<[Dictionary<String, Any>]> { fulfill, reject in
            let rows = (any as! Dictionary<String, Any>)["records"] as! [Dictionary<String, Any>]
            return fulfill(rows)
        }
    }
    
//    static func parseAndDecode (any : Decodable) -> Promise<Decodable> {
//        return Promise<Decodable> { fulfill, reject in
//            let decoder =  JSONDecoder();
//            let rows = (any as! Dictionary<String, Any>)["records"] as! [Dictionary<String, Any>]
//            let decodedObj = decoder.decode(any.self, from: rows)
//            return fulfill(rows)
//        }
//    }
}



