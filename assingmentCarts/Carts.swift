//
//  Carts.swift
//  assingmentCarts
//
//  Created by Macintosh on 03/01/24.
//

import Foundation
struct Carts{
    var id : Int
    var userId : Int
    var data : String
    var products : [Product]
}

struct Product {
    var productId : Int
    var quntity : Int
}
