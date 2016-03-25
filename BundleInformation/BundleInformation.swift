//
//  BundleInformation.swift
//
//  Created by hideyukitone on 2016/03/23.
//  Copyright © 2016年 hideyuki. All rights reserved.
//

import Foundation
import UIKit

// for manual mocking
internal protocol ObjectForInfoDictionaryKeyGettable {
    subscript(key: String) -> String? { get }
}

// for manual mocking
extension NSBundle: ObjectForInfoDictionaryKeyGettable {
    subscript(key: String) -> String? {
        return objectForInfoDictionaryKey(key) as? String
    }
}

// for manual mocking
internal protocol MirrorSubjectTypeGettable {
    var mirrorSubjectType: String { get }
}

public class BundleInformation: MirrorSubjectTypeGettable {
    
    // for manual mocking
    internal static var infoDictionaryManager: ObjectForInfoDictionaryKeyGettable = NSBundle.mainBundle()
    
    // for manual mocking
    internal static var mirrorManager: MirrorSubjectTypeGettable = BundleInformation()
    
    /**
     アプリ名
     
     */
    public static var appDisplayName: String {
        let display = infoDictionaryManager["CFBundleDisplayName"]
        let bundle  = infoDictionaryManager["CFBundleName"]
        
        switch   (display, bundle ) {
        case let (display?, _     ) where display.isEmpty: return getProductName()
        case let (display?, _     ):                       return display
        case let (_       ,bundle?) where bundle .isEmpty: return getProductName()
        case let (_       ,bundle?):                       return bundle
        default:                                           return getProductName()
        }
    }
    
    /**
     バージョン ex)1.0
     
     */
    public static var version: String {
        guard let ver = infoDictionaryManager["CFBundleShortVersionString"] else {
            return ""
        }
        
        return ver
    }
    
    /**
     ビルド ex)1
     
     */
    public static var build: String {
        guard let bui = infoDictionaryManager["CFBundleVersion"] else {
            return ""
        }
        
        return bui
    }
    
    private static func getProductName() -> String {
        let sepa = "."
        var array = mirrorManager.mirrorSubjectType.componentsSeparatedByString(sepa)
        
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
    
    // for manual mocking
    internal var mirrorSubjectType: String {
        return String(Mirror(reflecting: self).subjectType)
    }
    
}