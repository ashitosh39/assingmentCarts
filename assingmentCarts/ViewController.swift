//
//  ViewController.swift
//  assingmentCarts
//
//  Created by Macintosh on 03/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cartsCollectionView: UICollectionView!
    var carts : [Carts] = []
    var cartsDetailsViewControllerIdentifier : CartsDetailViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
       fatchData()
        registerXibWithCollectionView()
        initializiCollectionView()
    }
    
    func initializiCollectionView(){
        cartsCollectionView.dataSource = self
        cartsCollectionView.delegate = self
    }
    
    func registerXibWithCollectionView(){
        let uiNib = UINib(nibName : "CartsCollectionViewCell", bundle: nil)
        cartsCollectionView.register(uiNib, forCellWithReuseIdentifier: "CartsCollectionViewCell")
    }
    func fatchData(){
        let url = URL(string: "https://fakestoreapi.com/carts")
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: urlRequest){
            data, response,error in
            let urlResponce = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            for eachResponce in urlResponce{
                let cartsDictonary = eachResponce as! [String: Any]
                let cartsId = cartsDictonary["id"] as! Int
                let cartsUserId = cartsDictonary["userId"] as! Int
                let cartsDate = cartsDictonary["date"] as! String
                let product = cartsDictonary["products"] as! [[String: Any]]
                
                for productDictonary in product{
            let  cartProductId = productDictonary["productId"] as! Int
                    let cartQuantity = productDictonary["quantity"] as! Int
                    
                    let productObject = Product(productId: cartProductId, quntity : cartQuantity)
                    let newCart = Carts(id: cartsId,
                                        userId: cartsUserId,
                                        data: cartsDate,
                                        products:[productObject])
                    
                    self.carts.append(newCart)
                    print(self.carts)
                }
                
            }
            DispatchQueue.main.async{
                self.cartsCollectionView.reloadData()
            }
        }
        dataTask.resume()
    }
    

}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cartsCollectionViewCell = self.cartsCollectionView.dequeueReusableCell(withReuseIdentifier: "CartsCollectionViewCell", for: indexPath) as! CartsCollectionViewCell
        cartsCollectionViewCell.userIdLabel.text = String(carts[indexPath.item].userId)
        for i in 0...carts[indexPath.item].products.count-1{
            cartsCollectionViewCell.productIdLabel.text = carts[indexPath.item].products[i].productId.codingKey.stringValue
            cartsCollectionViewCell.quantityLabel.text = carts[indexPath.item].products[i].quntity.codingKey.stringValue
        }
    return cartsCollectionViewCell
 
    }
}
extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cartsDetailsViewControllerIdentifier = self.storyboard?.instantiateViewController(withIdentifier: "CartsDetailViewController") as! CartsDetailViewController
        
        cartsDetailsViewControllerIdentifier?.cartsContainer = carts[indexPath.item]
        navigationController?.pushViewController(cartsDetailsViewControllerIdentifier!, animated: true)
    }
}
extension ViewController :  UICollectionViewDelegateFlowLayout{
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItem indexPath : IndexPath)-> CGSize{
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let spaceBetweenTheCell : CGFloat = (flowLayout.minimumInteritemSpacing) ?? 0.0 + (flowLayout.sectionInset.left ?? 0.0) + (flowLayout.sectionInset.right ?? 0.0)
        let size = (self.cartsCollectionView.frame.width - spaceBetweenTheCell) 
            return CGSize(width: size  , height: size)
         }
        
}

