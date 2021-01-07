//
//  AppUtils.swift
//  DemoImplementFramework
//
//  Created by Hiren on 12/04/19.
//  Copyright © 2019 sufalam. All rights reserved.


import UIKit

class AppUtils: NSObject {
    
    static var arrProgressView : NSMutableArray = NSMutableArray();
    var Loader: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func startLoading(_ view : UIView){
        let viewForAI = UIView(frame: view.bounds);
        
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicatorView.backgroundColor = UIColor.white
        activityIndicatorView.style = .gray
        activityIndicatorView.startAnimating();
        activityIndicatorView.center = viewForAI.center;
        viewForAI.addSubview(activityIndicatorView);
        view.addSubview(viewForAI);
        self.arrProgressView.add(viewForAI);
    }
    
    
    static func stopLoading(){
        for i in 0 ..< self.arrProgressView.count {
            let progressObject : UIView! = self.arrProgressView.object(at: i) as? UIView;
            if(progressObject != nil){
                DispatchQueue.main.async {
                    progressObject!.removeFromSuperview()
                }
            }else{
                print("progressview is nil");
            }
        }
        self.arrProgressView.removeAllObjects();
    }
    
    static func convertDateToAnyFormatEnglish(sourceDateFormat:String,SourceDate:String,destinationDateFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceDateFormat
        let date = dateFormatter.date(from: SourceDate)
        dateFormatter.dateFormat = destinationDateFormat
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        if date != nil{
            let strDate = dateFormatter.string(from: date!)
            return strDate
        }else{
            return ""
        }
        
    }
    
    static func NsNumberToCurrencyFormate(_ Amount:NSNumber) -> String{
        let formatter = NumberFormatter()
        //formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.locale = Locale(identifier: "en_US")
        formatter.currencySymbol = ""
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: Amount as NSNumber) {
            let strAmount =  "\(formattedTipAmount)"
            return strAmount
        }else{
            let strAmount =  "\(Amount.doubleValue)"
            return strAmount
        }
    }
    
    
    static func ArrayToString(Array:NSMutableArray) -> String{
        
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: Array,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            return theJSONText
        }
        
        return ""
    }
    
    
}
