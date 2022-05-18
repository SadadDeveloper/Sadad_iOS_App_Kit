//
//  ViewController.swift
//  DemoImplementFramework
//
//  Created by Mehul Solanki on 15/03/19.
//  Copyright © 2019 sufalam. All rights reserved.
//

import UIKit
import SadadPaymentSDK


struct Product {
    var attributes = [String : Any]() // A dictionary of String keys and String values
}

class ViewController: UIViewController,SelectCardReponseDelegate {
   
    @IBOutlet weak var lblTotalAmout: UILabel!
    @IBOutlet weak var btnLoadFramework: UIButton!
    @IBOutlet weak var lblProductOneQTY: UILabel!
    @IBOutlet weak var lblProductSecondQTY: UILabel!
    
    @IBOutlet weak var URLswitch: UISwitch!
    @IBOutlet weak var imgProductOne: UIImageView!
    @IBOutlet weak var imgProductTwo: UIImageView!
    @IBOutlet weak var btnPlusProductOne: UIButton!
    
    @IBOutlet weak var btnMinusProductOne: UIButton!
    
    @IBOutlet weak var btnPlusProductTwo: UIButton!
    
    @IBOutlet weak var btnMinusProductTwo: UIButton!
    
    
    var strAccessToken:String = ""
    
    var ProductOneAmount:Int = 0
    var ProductSecondAmont:Double = 0.0
    var TotalAmount:Double = 0
    
    let arrProduct:NSMutableArray = NSMutableArray()
    var peeoplebyID = [Int: Product] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func switchSendboxValueChange(_ sender: Any) {
        if URLswitch.isOn == true{
            URLswitch.setOn(false, animated: true)
        }else{
            URLswitch.setOn(true, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProductOneAmount = 0
        ProductSecondAmont = 0
        TotalAmount = 0
        lblProductOneQTY.text = "0"
        lblProductSecondQTY.text = "0"
        arrProduct.removeAllObjects()
        setLayout()
        let DefaultAmvart = TotalValue()
//        print(DefaultAmvart)
    }
    
    
    func setLayout(){
        btnPlusProductOne.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        btnPlusProductOne.layer.borderWidth = 1.0
        
        btnMinusProductOne.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        btnMinusProductOne.layer.borderWidth = 1.0
        
        btnPlusProductTwo.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        btnPlusProductTwo.layer.borderWidth = 1.0
        
        btnMinusProductTwo.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        btnMinusProductTwo.layer.borderWidth = 1.0
        
        lblProductOneQTY.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        lblProductOneQTY.layer.borderWidth = 1.0
        lblProductSecondQTY.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        lblProductSecondQTY.layer.borderWidth = 1.0
        
        imgProductOne.layer.cornerRadius = 5
        imgProductTwo.layer.cornerRadius = 5
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        MyFramework.performSegueToFrameworkVC(caller: self)
    }
    
    func ReturnWebserviceURl(){
        Constant.strGenerateTokenURL = Constant.LIVE_strGenerateTokenURL
    }

    @IBAction func btnLoadFramework(_ sender: Any) {
        
        ReturnWebserviceURl()
        
        if ProductOneAmount > 0{

            let tempDIC = NSMutableDictionary()
            tempDIC.setValue("GUCCI Perfume", forKey: "itemname")
            tempDIC.setValue(ProductOneAmount, forKey: "quantity")
            tempDIC.setValue(ProductOneAmount, forKey: "amount")
            arrProduct.add(tempDIC)

        }
        
        if ProductSecondAmont > 0{
            let tempDIC = NSMutableDictionary()
            tempDIC.setValue("OUDY Perfume", forKey: "itemname")
            tempDIC.setValue(ProductSecondAmont, forKey: "quantity")
            tempDIC.setValue(ProductSecondAmont, forKey: "amount")
            arrProduct.add(tempDIC)
        }
    
        GenerateToken()
    }
    
    func ResponseData(DataDIC: NSMutableDictionary) {
        DispatchQueue.main.async {
//            print(DataDIC)
            let objTransferResponse  = self.storyboard?.instantiateViewController(withIdentifier: "TransferResponseVC") as! TransferResponseVC
            if let arrError = DataDIC.value(forKey: "error") as? [String:Any]{
                objTransferResponse.strMessage = arrError["message"] as? String ?? ""
                objTransferResponse.statusCode = arrError["statusCode"] as? Int ?? 0
                objTransferResponse.totalAmount = Int(self.TotalAmount)
            }else if let strMessage = DataDIC.value(forKey: "message") as? String{
                objTransferResponse.strMessage = strMessage
                objTransferResponse.statusCode = DataDIC.value(forKey: "statusCode") as! Int
            }else{
                if let numberAmount = DataDIC.value(forKey: "vpc_Amount") as? Int {
                    objTransferResponse.totalAmount = numberAmount/100
                    objTransferResponse.strMessage = "Transaction Failed"
                    objTransferResponse.statusCode = 430
                }else{
                    objTransferResponse.totalAmount = (Int(DataDIC.value(forKey: "vpc_Amount") as? String ?? "0")!)/100
                    objTransferResponse.strMessage = "Transaction Failed"
                    objTransferResponse.statusCode = 430
                }
                
            }
            
            if let strDic = DataDIC.value(forKey: "data") as? NSDictionary{
                objTransferResponse.transferResponse = strDic
                self.navigationController?.pushViewController(objTransferResponse, animated: true)
            }else if let arError = DataDIC.value(forKey: "error") as? NSDictionary{
                objTransferResponse.transferResponse = arError
                self.navigationController?.pushViewController(objTransferResponse, animated: true)
            }else{
                objTransferResponse.transferResponse = DataDIC
                self.navigationController?.pushViewController(objTransferResponse, animated: true)
            }
        }
    }
    
    func GenerateToken() {
        DispatchQueue.main.async {
        AppUtils.startLoading(self.view)
        }
        let strGenerateTokenURL = Constant.strGenerateTokenURL
        let Url = String(format: "\(strGenerateTokenURL)")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = NSMutableDictionary()
        var request = URLRequest(url: serviceUrl)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
                    let TempResponse = json as! NSDictionary
                    if let strAccessToken = TempResponse.value(forKey: "accessToken") as? String{
                        self.strAccessToken = strAccessToken
                        DispatchQueue.main.async {
                            AppUtils.stopLoading()
                            let podBundle = Bundle(for: SelectPaymentMethodVC.self)
                            let storyboard = UIStoryboard(name: "mainStoryboard", bundle: podBundle)
                            if let vc = storyboard.instantiateViewController(withIdentifier: "SelectPaymentMethodVC") as? SelectPaymentMethodVC{
                                vc.strMobile = "7080618000"
                                vc.strEmail = "test@gmail.com"
                                vc.delegate = self
                                vc.isSandbox = false
                                vc.strAccessToken = strAccessToken
                                vc.amount = Double(self.TotalValue())
                                vc.arrProductDetails = self.arrProduct
                                let navigationController = UINavigationController(rootViewController: vc)
                                navigationController.modalPresentationStyle = .overCurrentContext
                                self.present(navigationController, animated: true, completion: nil)
                            }                            
                        }
                    }
//                    print("AccessToken: ",self.strAccessToken)
//                    AppUtils.stopLoading()
                } catch {
                    print("Something went wrong please try again later.\(error)")
                }
            }else{
                 print("Something went wrong please try again later.")
            }
            
//            AppUtils.stopLoading()
            }.resume()
        
    }
    
    //First button Action
    
    @IBAction func btnPlusFirstAction(_ sender: Any) {
        ProductOneAmount = ProductOneAmount + 1
        lblProductOneQTY.text = "\(ProductOneAmount)"
        TotalAmount = TotalValue()
    }
    
    @IBAction func btnMinusFirstAction(_ sender: Any) {
        if ProductOneAmount > 0{
            ProductOneAmount = ProductOneAmount - 1
            lblProductOneQTY.text = "\(ProductOneAmount)"
            TotalAmount = TotalValue()
        }
    }
    
    //Second button Action
    @IBAction func btnSecondMinusAction(_ sender: Any) {
        if ProductSecondAmont > 0{
            ProductSecondAmont = ProductSecondAmont - 20.567
            lblProductSecondQTY.text = "\(ProductSecondAmont)"
            TotalAmount = TotalValue()
        }
    }
    
    @IBAction func btnSecondPlusAction(_ sender: Any) {
        ProductSecondAmont = ProductSecondAmont + 20.567
        lblProductSecondQTY.text = "\(ProductSecondAmont)"
        TotalAmount = TotalValue()
    }
    
    
    func TotalValue() -> Double{
        let TotalAmount:Double =  ProductSecondAmont + Double(ProductOneAmount)
        
        if TotalAmount != 0{
            btnLoadFramework.isEnabled = true
        }else{
            btnLoadFramework.isEnabled = false
        }
        
        self.lblTotalAmout.text = "Total Amount : \(TotalAmount) QAR"
        
        return Double(TotalAmount)
    }
    
    
}

