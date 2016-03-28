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
internal protocol InfomationForApplicationDelegateGettable {
    func classNameByDelegate(delegate: UIApplicationDelegate?) -> String?
}

public class BundleInformation: InfomationForApplicationDelegateGettable {
    
    // for manual mocking
    internal static var infoDictionaryManager: ObjectForInfoDictionaryKeyGettable = NSBundle.mainBundle()
    internal static var infoAppDelegateManager: InfomationForApplicationDelegateGettable = BundleInformation()
    
    /**
     Info.plistからアプリ名を取得
     ***
     取得方法
     - 「Bundle display name」から取得
     - 上で取得できない場合は「Bundle name」から取得
     ***
     */
    public static var appDisplayName: String? {
        let display = infoDictionaryManager["CFBundleDisplayName"]
        let bundle  = infoDictionaryManager["CFBundleName"]
        
        switch   (display, bundle ) {
        case let (display?, _     ) where display.isEmpty: return nil //Bundle display nameがあるのに空白の場合
        case let (display?, _     ):                       return display
        case let (_       ,bundle?) where bundle .isEmpty: return nil //Bundle nameがあるのに空白の場合
        case let (_       ,bundle?):                       return bundle
        default:                                           return nil
        }
    }
    
    /**
     バージョン ex)1.0
     
     */
    public static var version: String {
        return infoDictionaryManager["CFBundleShortVersionString"] ?? ""
    }
    
    /**
     ビルド ex)1
     
     */
    public static var build: String {
        return infoDictionaryManager["CFBundleVersion"] ?? ""
    }
    
    /**
     モジュール名
     - parameter UIApplicationDelegate: UIApplication.sharedApplication().delegateを渡してください。
     
     */
    public static func moduleName(delegate delegate: UIApplicationDelegate?) -> String? {
        let sepa = "."
        guard let array = infoAppDelegateManager.classNameByDelegate(delegate)?.componentsSeparatedByString(sepa) else {
            return nil
        }
        
        switch array.count {
        case 0:  return ""
        case 1:  return array[0]
            
        //プロジェクト名に.が入っている時を考慮
        default: return array.dropLast().joinWithSeparator(sepa)
        }
    }
    
    // for manual mocking
    internal func classNameByDelegate(delegate: UIApplicationDelegate?) -> String? {
        return delegate.map{NSStringFromClass($0.dynamicType)}
    }
}