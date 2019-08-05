# Steps for iOS Integration

1.installed following depenaded pods in your project.

'IQKeyboardManagerSwift'

'Material'

'KBNumberPad'

2.Drag the framework 'SadadPaymentSDK' in top of your project.

3.Add the framework sadadPaymentSDK in Project -> General -> Embedded Binaries.

4.Now go to the viewcontroller where you neeed to open or access framework and write.

import SadadPaymentSDK


# How To Use

1)Create product array with following details.

 `let arrProduct:NSMutableArray = NSMutableArray()`
   
 `let productDIC = NSMutableDictionary()`
 
 `productDIC.setValue("GUCCI Perfume", forKey: "itemname")`
 
 `productDIC.setValue(ProductOneQuantity, forKey: "quantity")`
 
 `productDIC.setValue(ProductOneAmount, forKey: "amount")`
 
 `arrProduct.add(productDIC)`
   
   
   
2)Use following code for open framework from your project.
   
   
   
   
`let podBundle = Bundle(for: SelectPaymentMethodVC.self)`

`let storyboard = UIStoryboard(name: "mainStoryboard", bundle: podBundle)`

`let vc = storyboard.instantiateViewController(withIdentifier: "SelectPaymentMethodVC") as! SelectPaymentMethodVC`

`vc.delegate = self`

`vc.isSandbox = true`

`vc.strAccessToken = strAccessToken`

`vc.amount = self.TotalValue()`

`vc.arrProductDetails = self.arrProduct`

`vc.modalPresentationStyle = .overCurrentContext`

`let navigationController = UINavigationController(rootViewController: vc)`

`self.present(navigationController, animated: true, completion: nil)`
