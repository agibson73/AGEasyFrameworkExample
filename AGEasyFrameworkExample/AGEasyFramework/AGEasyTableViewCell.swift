//
//  EasyTableViewCell.swift
//  Easy
//
//  Created by Alex Gibson on 1/1/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

class AGEasyTableViewCell: UITableViewCell {
    
    @IBOutlet var lbOutlets: [AGEasyLabel]!
    @IBOutlet var iVOutlets: [AGEasyImageView]!
    let downloader = AGEasyDownloader()

    
    
    var dict : NSDictionary = [String: String]() as NSDictionary {
        didSet {
            setUpCell()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(){
        
        // used to also get internal data Types
        if lbOutlets != nil && lbOutlets.count > 0{
            for lbs in lbOutlets{
                if lbs.parsingKey.isEmpty != true{
                    lbs.text = downloader.retrieveObjectForKey(json: dict, key: lbs.parsingKey) as! String?
                }
             }
        }
        
        
        if iVOutlets != nil && iVOutlets.count > 0{
            for iv in iVOutlets{
                iv.image = nil
            }
            for iv in iVOutlets{
                if iv.parsingKey.isEmpty != true{
                    let url = downloader.retrieveObjectForKey(json: dict, key: iv.parsingKey) as? String
                    if let imageURL = url{
                        if let data = AGEasyCache.sharedInstance.getDataForKey(imageURL){
                            iv.image = UIImage(data: data)
                        }
                        else{
                        DispatchQueue.global(priority: .high).async {
                            // do some task
                            let data = try? Data(contentsOf: URL(string: imageURL)!)
                            //move to cell code
                            
                            DispatchQueue.main.async {
                                // update some UI
                                if let realData = data{
                                    iv.image = UIImage(data: realData)
                                    AGEasyCache.sharedInstance.addData(realData, forKey: imageURL)
                                }
                                else{
                                    iv.image = nil
                                }
                            }
                           }
                        }
                    }
                }
            }
        }
        
    }

}
