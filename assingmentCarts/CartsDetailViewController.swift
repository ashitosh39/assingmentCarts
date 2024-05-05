//
//  CartsDetailViewController.swift
//  assingmentCarts
//
//  Created by Macintosh on 04/01/24.
//

import UIKit

class CartsDetailViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var productIdLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    var cartsContainer : Carts?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        
    }
    func bindData(){
        self.idLabel.text = cartsContainer?.id.description.codingKey.stringValue
        self.userIdLabel.text = cartsContainer?.userId.description.codingKey.stringValue
        self.dataLabel.text = cartsContainer?.data.description.codingKey.stringValue
        
        for i in 0...((cartsContainer?.products.count)!-1)
        {
            self.productIdLabel.text = cartsContainer?.products[i].productId.description.codingKey.stringValue
            self.quantityLabel.text = cartsContainer?.products[i].quntity.description.codingKey.stringValue
        }
        
    }
   
}
