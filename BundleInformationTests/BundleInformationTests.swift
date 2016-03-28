//
//  BundleInformationTests.swift
//  BundleInformationTests
//
//  Created by hideyukitone on 2016/03/23.
//  Copyright © 2016年 hideyuki. All rights reserved.
//

import XCTest
@testable import BundleInformation

class BundleInformationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBundleDisplayNameSome() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return "BundleDisplayName"
                default:                    return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.appDisplayName, "BundleDisplayName")
    }
    
    func testBundleDisplayNameEmpty() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return ""
                default:                    return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = CustomManager()
        XCTAssertEqual(BundleInformation.appDisplayName, nil)
    }
    
    func testBundleNameSome() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return "BundleName"
                default:                    return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.appDisplayName, "BundleName")
    }
    
    func testBundleNameEmpty() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return ""
                default:                    return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = CustomManager()
        XCTAssertEqual(BundleInformation.appDisplayName, nil)
    }

    func testMirrorSubjectTypeString() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return nil
                default:                    return "default"
                }
            }
        }
        
        BundleInformation.infoDictionaryManager = CustomManager()
        
        XCTAssertEqual(BundleInformation.appDisplayName, nil)
    }
    
    func testVersionNil() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleShortVersionString": return nil
                default:                           return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.version, "")
    }
    
    func testVersionSome() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleShortVersionString": return "1.2"
                default:                           return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.version, "1.2")
    }
    
    func testBuildNil() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleVersion": return nil
                default:                return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.build, "")
    }
    
    func testBuildSome() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            subscript(key: String) -> String? {
                switch key {
                case "CFBundleVersion": return "2.3"
                default:                return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.build, "2.3")
    }
    
    func testModuleNil() {
        struct InfoManager: InfomationForApplicationDelegateGettable {
            private func classNameByDelegate(delegate: UIApplicationDelegate?) -> String? {
                return nil
            }
        }
        BundleInformation.infoAppDelegateManager = InfoManager()
        XCTAssertEqual(BundleInformation.moduleName(delegate: UIApplication.sharedApplication().delegate), nil)
    }
    
    func testModuleString1() {
        struct InfoManager: InfomationForApplicationDelegateGettable {
            private func classNameByDelegate(delegate: UIApplicationDelegate?) -> String? {
                return "xxx"
            }
        }
        BundleInformation.infoAppDelegateManager = InfoManager()
        XCTAssertEqual(BundleInformation.moduleName(delegate: UIApplication.sharedApplication().delegate), "xxx")
    }
    
    func testModuleString2() {
        struct InfoManager: InfomationForApplicationDelegateGettable {
            private func classNameByDelegate(delegate: UIApplicationDelegate?) -> String? {
                return "xxx.yyy"
            }
        }
        BundleInformation.infoAppDelegateManager = InfoManager()
        XCTAssertEqual(BundleInformation.moduleName(delegate: UIApplication.sharedApplication().delegate), "xxx")
    }
    
    func testModuleString3() {
        struct InfoManager: InfomationForApplicationDelegateGettable {
            private func classNameByDelegate(delegate: UIApplicationDelegate?) -> String? {
                return "xxx.yyy.zzz"
            }
        }
        BundleInformation.infoAppDelegateManager = InfoManager()
        XCTAssertEqual(BundleInformation.moduleName(delegate: UIApplication.sharedApplication().delegate), "xxx.yyy")
    }
    
    func testModuleString4() {
        struct InfoManager: InfomationForApplicationDelegateGettable {
            private func classNameByDelegate(delegate: UIApplicationDelegate?) -> String? {
                return ""
            }
        }
        BundleInformation.infoAppDelegateManager = InfoManager()
        XCTAssertEqual(BundleInformation.moduleName(delegate: UIApplication.sharedApplication().delegate), "")
    }
}
