# What's New

1. Added Support for Simulator and real device both. So, now you can add framework for simulator in your app and test.
2. Support to swift 5

# Steps for iOS Integration

1.installed following depenaded pods in your project.

pod 'IQKeyboardManagerSwift'
pod 'MaterialComponents/TextControls+FilledTextAreas'
pod 'MaterialComponents/TextControls+FilledTextFields''

2.Drag the framework 'SadadPaymentSDK' in top of your project. what ever you want to run app into(i.e. App or for simulator)

3.Add the framework sadadPaymentSDK in Project -> General -> Frameworks and Libraries -> select Embed and Signin for that framework.

4.Now go to the viewcontroller where you neeed to open or access framework and write.
```
import SadadPaymentSDK
```


# How To Use

1)Create product array with following details.

```
 let arrProduct:NSMutableArray = NSMutableArray()
   
 let productDIC = NSMutableDictionary()
 
 productDIC.setValue("GUCCI Perfume", forKey: "itemname")
 
 productDIC.setValue(ProductOneQuantity, forKey: "quantity")
 
 productDIC.setValue(ProductOneAmount, forKey: "amount")
 
 arrProduct.add(productDIC)
 ```
   
   
   
2)Use following code for open framework from your project.
   
   
   
```
let podBundle = Bundle(for: SelectPaymentMethodVC.self)

let storyboard = UIStoryboard(name: "mainStoryboard", bundle: podBundle)

let vc = storyboard.instantiateViewController(withIdentifier: "SelectPaymentMethodVC") as! SelectPaymentMethodVC

vc.delegate = self

vc.isSandbox = false

vc.strAccessToken = strAccessToken

vc.amount = self.TotalValue()

vc.arrProductDetails = self.arrProduct

vc.modalPresentationStyle = .overCurrentContext

let navigationController = UINavigationController(rootViewController: vc)

self.present(navigationController, animated: true, completion: nil)
```


3)To get the callback from this response extend your class with following Delegate:

```
class ViewController: UIViewController,SelectCardReponseDelegate {
}
```

4)And call Its delegate method. In which you will get Success/Failure from the SDK. You will get response dictionary in below method. In my demo I have fetch message and statuscode and data from that dictionary and passed to another controller to display success failure message properly.

```
func ResponseData(DataDIC: NSMutableDictionary) {
    DispatchQueue.main.async {
        let objTransferResponse  = self.storyboard?.instantiateViewController(withIdentifier: "TransferResponseVC") as! TransferResponseVC
        objTransferResponse.strMessage = DataDIC.value(forKey: "message") as! String
        objTransferResponse.statusCode = DataDIC.value(forKey: "statusCode") as! Int
        
        if let strDic = DataDIC.value(forKey: "data") as? NSDictionary{
            objTransferResponse.transferResponse = strDic
            self.navigationController?.pushViewController(objTransferResponse, animated: true)
        }
    }
}
```

5)As per the statuscode value set Success/failure message in your controller. For more details check **setResponse()** method in **TransferResponseVC.swift** file. included in demo. For success you will get **statuscode** value **200**. and for failed Transaction you will get **statuscode** value **400**.


