//
//  RestApiManager.swift
//  AwareShpperv2
//
//  Created by Umoru Joseph on 11/17/15.
//  Copyright © 2015 Umoru Joseph. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) ->Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "https://mobileappserver1.herokuapp.com/products/productTypes"
    
    func getPaperGoods(onCompletion: (JSON) -> Void) {
        let route = "https://mobileappserver1.herokuapp.com/products/Paper_Goods"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    func getBeverages(onCompletion: (JSON) -> Void) {
        let route = "https://mobileappserver1.herokuapp.com/products/Beverages"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    func getBreadBakery(onCompletion: (JSON) -> Void) {
        let route = "https://mobileappserver1.herokuapp.com/products/Bread_Bakery"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getDairyProducts(onCompletion: (JSON) -> Void) {
        let route = "https://mobileappserver1.herokuapp.com/products/Dairy"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getShops(onCompletion: (JSON) -> Void) {
        let route = "https://mobileappserver1.herokuapp.com/products/shops"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}


