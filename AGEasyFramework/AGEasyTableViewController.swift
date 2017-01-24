//
//  EasyTableViewController.swift
//  Easy
//
//  Created by Alex Gibson on 1/2/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

class AGEasyTableViewController: UITableViewController {
    
    var data = [NSDictionary]()
    @IBInspectable var cellIdentifier : String = "cell" {
        didSet {
           
        }
    }
    @IBInspectable var apiURL : String = String()
    @IBInspectable var shouldLogCall : Bool = true
    
    @IBInspectable var estimatedRowHeight : CGFloat = 0 {
        didSet {
            self.tableView.estimatedRowHeight = estimatedRowHeight
        }
    }
    
    @IBInspectable var fixedRowHeight : CGFloat = 200
    
    @IBInspectable var parsingKey : String = String()
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.tintColor = UIColor.lightGray
        activityIndicator.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        activityIndicator.frame = self.view.frame
        self.tableView.addSubview(activityIndicator)
        self.tableView.bringSubview(toFront: activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        if apiURL.isEmpty != true{
            let downloader = AGEasyDownloader()
            downloader.downloadSomeData(shouldLog: shouldLogCall,apiUrl: apiURL, parsingKey: parsingKey, completion: {
                data,error in
                if error != nil{
                    
                }else{
                    if data != nil{
                        DispatchQueue.main.async {
                            self.data = data!
                            self.tableView.reloadData()
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                }

            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if cellIdentifier.isEmpty != true{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AGEasyTableViewCell
        cell.dict = data[indexPath.row]
        return cell
        }else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
            return cell!
        }

    }
    


    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if fixedRowHeight > 0{
            return fixedRowHeight
        }else{
            return estimatedRowHeight
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if fixedRowHeight > 0{
            return fixedRowHeight
        }else{
            return UITableViewAutomaticDimension
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
