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
    func objectForInfoDictionaryKey(key: String) -> AnyObject?
}

// for manual mocking
extension NSBundle: ObjectForInfoDictionaryKeyGettable {}

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
        if let name = infoDictionaryManager.objectForInfoDictionaryKey("CFBundleDisplayName") as? String {
            return name == "" ? getProductName() : name
        }else if let name = infoDictionaryManager.objectForInfoDictionaryKey("CFBundleName") as? String {
            return name == "" ? getProductName() : name
        }else {
            return getProductName()
        }
    }
    
    /**
     バージョン ex)1.0
     
     */
    public static var version: String {
        guard let ver = infoDictionaryManager.objectForInfoDictionaryKey("CFBundleShortVersionString") as? String else {
            return ""
        }
        
        return ver
    }
    
    /**
     ビルド ex)1
     
     */
    public static var build: String {
        guard let bui = infoDictionaryManager.objectForInfoDictionaryKey("CFBundleVersion") as? String else {
            return ""
        }
        
        return bui
    }
    
    private static func getProductName() -> String {
        let sepa = "."
        let array = mirrorManager.mirrorSubjectType.componentsSeparatedByString(sepa)
        
        switch array.count {
        case 0:  return ""
        case 1:  return array[0]
            
        //プロジェクト名に.が入っている時を考慮
        default: return array.dropLast().joinWithSeparator(sepa)
        }
    }
    
    // for manual mocking
    internal var mirrorSubjectType: String {
        return String(Mirror(reflecting: self).subjectType)
    }
    
}