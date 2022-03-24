//
//  TransferResponseVC.swift
//  Demo
//
//  Created by Hiren on 22/04/19.
//  Copyright © 2019 sufalam. All rights reserved.
//

import UIKit
import AVKit

class TransferResponseVC: UIViewController {
    
    @IBOutlet weak var imgTransferResponse: UIImageView!
    
    @IBOutlet weak var lblTransectionMessage: UILabel!
    @IBOutlet weak var lblTransectionAmount: UILabel!
    @IBOutlet weak var lblTransectionID: UILabel!
    @IBOutlet weak var lblDateAndTime: UILabel!
  
    
    
    var isfromDebitCard:Bool = false
    var isCreditCard:Bool = false
    var isfromPaymentViaSadad = false
    var strMessage:String = ""
    
    var transferResponse:NSDictionary = NSDictionary()
    var statusCode:Int = 0
    var totalAmount = 0
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        setResponse()
    }
    
    func setResponse(){
        if statusCode == 200{
            if let transectionStatusID = transferResponse.value(forKey: "transactionstatus") as? Int{
                if transectionStatusID == Constant.TransectionSuccessfull{
                    self.imgTransferResponse.image = UIImage(named: "ic_Success")
                    self.lblTransectionMessage.text = "Payment - Success"
                    playSound()
                }else{
                    self.imgTransferResponse.image = UIImage(named: "ic_Cancel")
                     self.lblTransectionMessage.text = "Payment - Failed"
                    playSoundForFailure()
                }
            }else if let status = transferResponse.value(forKey: "transactionstatusId") as? Int{
                if status == Constant.TransectionSuccessfull {
                    self.imgTransferResponse.image = UIImage(named: "ic_Success")
                    self.lblTransectionMessage.text = "Payment - Success"
                    playSound()
                }else{
                    self.imgTransferResponse.image = UIImage(named: "ic_Cancel")
                    playSoundForFailure()
                    self.lblTransectionMessage.text = "Payment - Failed"
                }
            }
            
            if let createdDate = transferResponse.value(forKey: "date") as? String{
                self.lblDateAndTime.text = AppUtils.convertDateToAnyFormatEnglish(sourceDateFormat: Constant.strDateFormate, SourceDate: createdDate, destinationDateFormat: "d MMM yyyy h:mm a")
            }
            
            if let strcreatedDate = transferResponse.value(forKey: "created") as? String{
                self.lblDateAndTime.text = AppUtils.convertDateToAnyFormatEnglish(sourceDateFormat: Constant.strDateFormateFull, SourceDate: strcreatedDate, destinationDateFormat: "d MMM yyyy h:mm a")
            }
            
            if let strTransectionID = transferResponse.value(forKey: "transactionnumber") as? String{
                    self.lblTransectionID.text = strTransectionID
            }
            
            if let strSadadTransection =  transferResponse.value(forKey: "invoicenumber") as? String{
                self.lblTransectionID.text = strSadadTransection
            }
            
            let amount = (transferResponse.value(forKey: "amount") as! Double)
            
            self.lblTransectionAmount.text = AppUtils.NsNumberToCurrencyFormate(NSNumber(value: amount))
           
        }else if statusCode == 400{
           
            self.imgTransferResponse.image = UIImage(named: "ic_Cancel")
            playSoundForFailure()
            self.lblTransectionMessage.text = "Payment - Failed"
          
            if let createdDate = transferResponse.value(forKey: "date") as? String{
                self.lblDateAndTime.text = AppUtils.convertDateToAnyFormatEnglish(sourceDateFormat: Constant.strDateFormate, SourceDate: createdDate, destinationDateFormat: "d MMM yyyy h:mm a")
            }
            
            if let strcreatedDate = transferResponse.value(forKey: "created") as? String{
                self.lblDateAndTime.text = AppUtils.convertDateToAnyFormatEnglish(sourceDateFormat: Constant.strDateFormateFull, SourceDate: strcreatedDate, destinationDateFormat: "d MMM yyyy h:mm a")
            }
            
            if let strTransectionID = transferResponse.value(forKey: "transactionnumber") as? String{
                self.lblTransectionID.text = strTransectionID
            }
            
            if let strSadadTransection =  transferResponse.value(forKey: "invoicenumber") as? String{
                self.lblTransectionID.text = strSadadTransection
            }
            
            let amount = (transferResponse.value(forKey: "amount") as! Double)
            self.lblTransectionAmount.text = AppUtils.NsNumberToCurrencyFormate(NSNumber(value: amount))
        }else if statusCode == 430{
            self.lblTransectionID.text = " - "
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let createdDate = dateFormatter.string(from: currentDate)
            
            self.lblDateAndTime.text = AppUtils.convertDateToAnyFormatEnglish(sourceDateFormat: Constant.strDateFormate, SourceDate: createdDate, destinationDateFormat: "d MMM yyyy h:mm a")
            
            self.imgTransferResponse.image = UIImage(named: "ic_Cancel")
            playSoundForFailure()
            self.lblTransectionMessage.text = self.strMessage
            self.lblTransectionAmount.text = AppUtils.NsNumberToCurrencyFormate(NSNumber(value: totalAmount))
        }
    }
    
    
    //MARK:- Sound for Success PopUP   soft-tick.mp3
    func playSound() {
        let sound = Bundle.main.url(forResource: "Success", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //case-closed.mp3
    func playSoundForFailure() {
        let sound = Bundle.main.url(forResource: "Failure", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    

    @IBAction func btnDoneAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
