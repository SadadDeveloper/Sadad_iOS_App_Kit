//
//  Constant.swift
//  Demo
//
//  Created by Hiren on 22/04/19.
//  Copyright © 2019 sufalam. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    //TranasectionID
    static let TransectionRefund:Int = 4
    static let TransectionSuccessfull:Int = 3
    static let TransectionFailed:Int = 2
    static let TransectionInProgress:Int = 1
    static let TransectionPending:Int = 5
    
    static let strDateFormate:String = "yyyy-MM-dd"
    static let strDateFormateFull:String = "yyyy-MM-dd HH:mm:ss"
    
    //Local
    static let LOCAL_strGenerateTokenURL:String = "http://192.168.1.106/sadadsdkclient/"
    //Sendbox
    static let SANDBOX_strGenerateTokenURL:String = "https://sadad.de/sadadSDKTestConfig/index.php"
    //Live
    static let LIVE_strGenerateTokenURL:String = "http://172.104.180.157/sadadSDKTestConfig/index.php"
    
    static var strGenerateTokenURL:String = ""
    
        
}
