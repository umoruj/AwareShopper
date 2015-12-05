//
//  ProductTableViewController.swift
//  AwareShpperv2
//
//  Created by Umoru Joseph on 11/17/15.
//  Copyright © 2015 Umoru Joseph. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class ProductTableViewController: UITableViewController,CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimote")
    let stores = [
        8175: "Aldi1",
        22782: "Aldi2"
    ]
    
    var presentStore = String()
    var products1 = [String]()
    var products2 = [String]()
    var shopsAvailable = [String]()
    
    var productCatgories = [String]()
    var productCatImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    var goods = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCatgories = ["BEVERAGES", "BREAD AND SANDWICHES",
            "DAIRY PRODUCTS", "PAPER GOODS"]
        productCatImages = ["beverages.jpg", "bread_bakery.jpg",
            "dairy_products.jpg", "paper_goods.jpg"]
        goods = ["Beverages", "Bread_Bakery",
            "Dairy_Products", "Paper_Goods"]
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse){
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
        
        tableView.estimatedRowHeight = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon!
            let minor = closestBeacon.minor.integerValue as Int
            if let val = self.stores[minor]{
            presentStore = val
            }
        }
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return productCatgories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
            self.tableView.dequeueReusableCellWithIdentifier(
                "ProductTableCell", forIndexPath: indexPath)
                as! ProductTableViewCell
            
            let row = indexPath.row
            cell.productLabel.font =
                UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            cell.productLabel.text = productCatgories[row]
            cell.productImage.image = UIImage(named: productCatImages[row])
            return cell
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowProductDetails" {
            let detailViewController = segue.destinationViewController
                as! ProductDetailTableViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            detailViewController.webSite = goods[row]
            print(presentStore)
            detailViewController.presentStore1 = presentStore
        }
    }

}
