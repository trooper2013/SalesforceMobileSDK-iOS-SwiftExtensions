//
//  SDKSmartStoreExtensions.swift
//  Test2
//
//  Created by Raj Rao on 11/17/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSDKCore
import SmartStore
import SmartSync
import PromiseKit

extension SFSmartSyncSyncManager {
    
    var promises: Promises {
        return Promises(api: self)
    }
    
    class Promises {
        let api : SFSmartSyncSyncManager
        
        init(api: SFSmartSyncSyncManager) {
            self.api = api
            
        }
        
        func syncUp (options: SFSyncOptions,soupName: String) -> Promise<SFSyncState> {
            
            return Promise<SFSyncState> { fulfill ,reject in
                api.syncUp(with: options, soupName: soupName) { (syncState) in
                    fulfill(syncState)
                }
            }
        }
        
        func syncUp (target: SFSyncUpTarget,  options: SFSyncOptions, soupName: String) -> Promise<SFSyncState> {
            return Promise<SFSyncState> { fulfill ,reject in
                api.syncUp(with: target, options: options, soupName: soupName) { (syncState) in
                    fulfill(syncState)
                }
            }
        }
        
        func syncUp (target: SFSyncUpTarget,  options: SFSyncOptions, soupName: String,  syncName: String) -> Promise<SFSyncState> {
            return Promise<SFSyncState> { fulfill ,reject in
                api.syncUp(with: target, options: options, soupName: soupName, syncName: syncName) { (syncState) in
                    fulfill(syncState)
                }
            }
        }
        
        func syncDown (target: SFSyncDownTarget, options: SFSyncOptions, soupName: String) -> Promise<SFSyncState> {
            return Promise<SFSyncState> { fulfill ,reject in
                api.syncDown(with: target, options: options, soupName: soupName, update: { (syncState) in
                    fulfill(syncState)
                })
            }
        }
        
        func syncDown (target: SFSyncDownTarget, options: SFSyncOptions, soupName: String,syncName: String) -> Promise<SFSyncState> {
            return Promise<SFSyncState> { fulfill ,reject in
                api.syncDown(with: target, options: options, soupName: soupName,syncName: syncName, update: { (syncState) in
                    fulfill(syncState)
                })
            }
        }
        
        func reSync ( syncId: NSNumber) -> Promise<SFSyncState> {
            return Promise<SFSyncState> { fulfill ,reject in
                api.reSync(syncId, update: { (syncState) in
                    fulfill(syncState)
                })
            }
        }
        
        func reSync ( syncName: String) -> Promise<SFSyncState> {
            return Promise<SFSyncState> { fulfill ,reject in
                api.reSync(byName: syncName, update: { (syncState) in
                    fulfill(syncState)
                })
            }
        }
    
    }
    
    
    
}
