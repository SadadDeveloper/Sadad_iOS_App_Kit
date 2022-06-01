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
    
    //Sendbox
    static let SANDBOX_strGenerateTokenURL:String = "https://sadad.de/sadadSDKTestConfig/index.php"
    static let SANDBOX_strGenerateTokenURL1:String = "http://paylna.me/sadadSDKLiveConfig/awsindex.php"
    //Live
    static let LIVE_strGenerateTokenURL_r:String = "http://paylna.me/sadadSDKLiveConfig/rdserverindex.php"
    static let LIVE_strGenerateTokenURL:String = "http://paylna.me/sadadSDKLiveConfig/index.php"
    
    static var strGenerateTokenURL:String = ""
    
        
}
