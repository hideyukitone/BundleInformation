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
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return "BundleDisplayName"
                default:                    return "default"
                }
            }
        }
            
        XCTAssertEqual(CustomBundleInformation.appDisplayName, "BundleDisplayName")
    }
    
    func testBundleDisplayNameEmpty() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return ""
                default:                    return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.appDisplayName, nil)
    }
    
    func testBundleNameSome() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return "BundleName"
                default:                    return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.appDisplayName, "BundleName")
    }
    
    func testBundleNameEmpty() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return ""
                default:                    return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.appDisplayName, nil)
    }

    func testMirrorSubjectTypeString() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return nil
                default:                    return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.appDisplayName, nil)
    }
    
    func testVersionNil() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleShortVersionString": return nil
                default:                           return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.version, "")
    }
    
    func testVersionSome() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleShortVersionString": return "1.2"
                default:                           return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.version, "1.2")
    }
    
    func testBuildNil() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleVersion": return nil
                default:                return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.build, "")
    }
    
    func testBuildSome() {
        class CustomBundleInformation: BundleInformation {
            override class func objectForInfoDictionaryKey(_ key: String) -> String? {
                switch key {
                case "CFBundleVersion": return "2.3"
                default:                return "default"
                }
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.build, "2.3")
    }
    
    func testModuleNil() {
        class CustomBundleInformation: BundleInformation {
            override class func classNameByDelegate(_ delegate: UIApplicationDelegate?) -> String? {
                return nil
            }
        }
        XCTAssertEqual(CustomBundleInformation.moduleName(delegate: UIApplication.shared.delegate), nil)
    }
    
    func testModuleString1() {
        class CustomBundleInformation: BundleInformation {
            override class func classNameByDelegate(_ delegate: UIApplicationDelegate?) -> String? {
                return "xxx"
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.moduleName(delegate: UIApplication.shared.delegate), "xxx")
    }
    
    func testModuleString2() {
        class CustomBundleInformation: BundleInformation {
            override class func classNameByDelegate(_ delegate: UIApplicationDelegate?) -> String? {
                return "xxx.yyy"
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.moduleName(delegate: UIApplication.shared.delegate), "xxx")
    }
    
    func testModuleString3() {
        class CustomBundleInformation: BundleInformation {
            override class func classNameByDelegate(_ delegate: UIApplicationDelegate?) -> String? {
                return "xxx.yyy.zzz"
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.moduleName(delegate: UIApplication.shared.delegate), "xxx.yyy")
    }
    
    func testModuleString4() {
        class CustomBundleInformation: BundleInformation {
            override class func classNameByDelegate(_ delegate: UIApplicationDelegate?) -> String? {
                return ""
            }
        }
        
        XCTAssertEqual(CustomBundleInformation.moduleName(delegate: UIApplication.shared.delegate), "")
    }
}
