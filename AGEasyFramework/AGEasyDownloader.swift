//
//  AGEasyDownloader.swift
//  Easy
//
//  Created by Alex Gibson on 1/20/17.
//  Copyright © 2017 AG. All rights reserved.
//

import UIKit

class AGEasyDownloader: NSObject {
    
    func downloadSomeData(shouldLog:Bool,apiUrl:String,parsingKey:String,completion:@escaping (_ data:[NSDictionary]?,_ error:Error?)->Void){

        let request = URLRequest(url: URL(string: apiUrl)!)
        URLSession.shared.dataTask(with: request, completionHandler: {
            data,response,error in
            if error == nil{
                do{
                    let Json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if shouldLog == true{
                        print("the json is \(Json)")
                    }
                    
                    let results : AnyObject! = self.retrieveObjectForKey(json: Json as AnyObject, key: parsingKey)
                    if let collection = results as? [NSDictionary] {
                        if shouldLog == true{
                            print("Our results as a dictionary is \(collection)")
                        }
                        completion(collection,nil)
                    }
                    
                } catch _{
                    if shouldLog == true{
                        print("Parsing error")
                    }
                    
                    completion(nil,error)
                }
                
                
                
            }else{
                print("The error is \(error)")
                completion(nil, error)
            }
        }).resume()
    }
    
    func dataTypes()->[String]{
        return ["garble","<a>","<d>"]
    }
    
    // get the index
    func findAttributeType(_ str:String)->Int{
        let dataTypes = self.dataTypes()
        for subString in dataTypes{
            if str.range(of: subString) != nil{
                let indx = self.dataTypes().index(of: subString)
                return indx!
            }
            
        }
        return 0
    }
    
    func attributeForKey(json:AnyObject,key:String)->AnyObject?{
        if key.isEmpty{
            return json
        }
        if key.contains("<a>") || key.contains("<d>") || key.contains("<garble"){
            guard let parsedKey = stripKeyFromString(key: key) else{return nil}
            guard let parsedObject = retrieveObjectForKey(json:json,key: parsedKey) else{return nil}
            guard let remainingKey = remainingKey(key: key) else{return parsedObject}
            
            //we need to run it again
            //recursive
            let _ = self.attributeForKey(json: parsedObject, key: remainingKey)
            
        }else{
            return retrieveObjectForKey(json: json, key: key)
        }
        return nil
    }
    
    func retrieveObjectForKey(json:AnyObject,key:String)->AnyObject?{
        if json is NSDictionary{
            return json.value(forKey: key) as AnyObject?
        }
        return json
    }
    
    func stripKeyFromString(key:String)->String?{
        let indx = findAttributeType(key)
        let range = key.range(of: self.dataTypes()[indx])
        return key.substring(from: (range?.lowerBound)!)
    }
    
    func remainingKey(key:String)->String?{
        let range = key.range(of: key)
        let stringWithoutType = key.substring(to: (range?.upperBound)!)
        return stringWithoutType
    }

}
