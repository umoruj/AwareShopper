//
//  ProductDetailTableViewController.swift
//  AwareShpperv2
//
//  Created by Umoru Joseph on 11/17/15.
//  Copyright © 2015 Umoru Joseph. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class ProductDetailTableViewController: UITableViewController{
    var webSite: String?
    var presentStore1: String?
    var attractionNames = [String]()
    var shopsAvailable = [String]()
    var productsAvailShop = [String]()
    var ProductName = [String]()
    var ProductPrice = [String]()
    var ProductDiscount = [String]()
    
    
    
    func getShops(){
        RestApiManager.sharedInstance.getShops{json -> Void in
            let numberOfShops = json["shops"].count as Int
            for count in 1...numberOfShops{
                var location2 = "Aldi"
                location2 += "\(count)"
                self.shopsAvailable.append(location2)
            }
        }
    }
    
    func getproductsAvailShop(storeLocaton: String){
        RestApiManager.sharedInstance.getShops{json -> Void in
            let numberOfproductsAvailShop = json["shops"][storeLocaton]["Product"].count as Int
            var p = 0
            for _ in 1...numberOfproductsAvailShop{
                let prod = json["shops"][storeLocaton]["Product"][p].string as String!
                self.productsAvailShop.append(prod)
                p++
            }
        }
    }
    
    func getProducts(productType: String){
        if(productType == "Beverages"){
        RestApiManager.sharedInstance.getBeverages{json -> Void in
            let numberOfProducts = json[productType].count as Int
            var x = 0
            for _ in 1...numberOfProducts{
                let name = json[productType][x]["name"].string as String!
                let price = json[productType][x]["price"].double as Double!
                let disocount = json[productType][x]["discount"].double as Double!
                
                let a = String(price)
                let b = String(disocount)
                
                self.ProductName.append(name)
                self.ProductPrice.append(a)
                self.ProductDiscount.append(b)
                x++
            }
        }
        }else if(productType == "Bread_Bakery"){
            RestApiManager.sharedInstance.getBreadBakery{json -> Void in
                let numberOfProducts = json[productType].count as Int
                var x = 0
                for _ in 1...numberOfProducts{
                    let name = json[productType][x]["name"].string as String!
                    let price = json[productType][x]["price"].double as Double!
                    let disocount = json[productType][x]["discount"].double as Double!
                    
                    let c = String(price)
                    let d = String(disocount)
                    
                    self.ProductName.append(name)
                    self.ProductPrice.append(c)
                    self.ProductDiscount.append(d)
                    x++                }
            }
        }else if(productType == "Dairy_Products"){
            RestApiManager.sharedInstance.getDairyProducts{json -> Void in
                let numberOfProducts = json[productType].count as Int
                var x = 0
                for _ in 1...numberOfProducts{
                    let name = json[productType][x]["name"].string as String!
                    let price = json[productType][x]["price"].double as Double!
                    let disocount = json[productType][x]["discount"].double as Double!
                    
                    let e = String(price)
                    let f = String(disocount)
                    
                    self.ProductName.append(name)
                    self.ProductPrice.append(e)
                    self.ProductDiscount.append(f)
                    x++
                }
            }
        }else if(productType == "Paper_Goods"){
            RestApiManager.sharedInstance.getPaperGoods{json -> Void in
                let numberOfProducts = json[productType].count as Int
                var x = 0
                for _ in 1...numberOfProducts{
                    let name = json[productType][x]["name"].string as String!
                    let price = json[productType][x]["price"].double as Double!
                    let disocount = json[productType][x]["discount"].double as Double!
                    
                    let g = String(price)
                    let h = String(disocount)
                    
                    self.ProductName.append(name)
                    self.ProductPrice.append(g)
                    self.ProductDiscount.append(h)
                    x++                }
            }
        }else{
            print("wrong segue")
        }
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        getproductsAvailShop(presentStore1!)
        getShops()
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        SwiftLoading().showLoading()
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            if self.productsAvailShop.contains(self.webSite!) {
                self.getProducts(self.webSite!)
                SwiftLoading().hideLoading()
            }else{
                self.ProductName.append("Currently not available in this store")
                self.ProductPrice.append("")
                self.ProductDiscount.append("")
                SwiftLoading().hideLoading()
            }
        })
        
        var timer1 = NSTimer()
        timer1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "view1234", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let a = ProductName.count
            
            return a

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        self.tableView.dequeueReusableCellWithIdentifier(
            "ProductDetailTableCell", forIndexPath: indexPath)
            as! ProductDetailTableViewCell
        
        let row = indexPath.row
        cell.productLabel.font =
            UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.productLabel.text = ProductName[row]
        cell.priceLabel.text = ProductPrice[row]
        cell.discountPriceLabel.text = ProductDiscount[row]
        return cell
    }
    
    func view1234() {
        self.tableView.reloadData()
    }

}
