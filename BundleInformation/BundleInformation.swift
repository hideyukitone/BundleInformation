//
//  BundleInformation.swift
//
//  Created by hideyukitone on 2016/03/23.
//  Copyright © 2016年 hideyuki. All rights reserved.
//

import Foundation
import UIKit

public class BundleInformation {
    
    /**
     アプリ名
     
     */
    public static var appDisplayName: String {
        if let name = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName") as? String {
            return name
        }else if let name = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String {
            return name
        }else {
            let sepa = "."
            var array = String(Mirror(reflecting: self).subjectType).componentsSeparatedByString(sepa)
            
            if array.count >= 2 {
                //プロジェクト名に.が入っている時を考慮
                
                array.removeAtIndex(array.count - 1)
                
                var rtn = ""
                for str in array {
                    if rtn == "" {
                        rtn = str
                    }else {
                        rtn += sepa + str
                    }
                }
                
                return rtn
            }else {
                return array.first ?? ""
            }
        }
    }
    
    /**
     バージョン ex)1.0
     
     */
    public static var version: String {
        guard let ver = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String else {
            return ""
        }
        
        return ver
    }
    
    /**
     ビルド ex)1
     
     */
    public static var build: String {
        guard let bui = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as? String else {
            return ""
        }
        
        return bui
    }
    
}