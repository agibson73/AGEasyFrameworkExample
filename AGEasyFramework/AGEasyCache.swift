//
//  EasyCache.swift
//  Easy
//
//  Created by Alex Gibson on 1/2/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

class AGEasyCache: NSObject {
    
    
    var imageDataDict = NSMutableDictionary()

    class var sharedInstance: AGEasyCache {
        struct Static {
            static let instance : AGEasyCache = AGEasyCache()
        }
        
        return Static.instance
    }
    
    func addData(_ imageData:Data,forKey:String){
        imageDataDict.setObject(imageData, forKey: forKey as NSCopying)
    }
    func getDataForKey(_ forKey:String!)->Data?{
        if forKey != nil{
            if let data = imageDataDict.object(forKey: forKey) as? Data{
                return data
            }
            else{
                return nil
            }
        }
        else{
            return nil
        }
    }

}
