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
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
                switch key {
                case "CFBundleDisplayName": return "BundleDisplayName"
                default:                    return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.appDisplayName, "BundleDisplayName")
    }
    
    func testBundleDisplayNameNil() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
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
    
    func testMirrorSubjectTypeString1() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable, MirrorSubjectTypeGettable {
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return nil
                default:                    return "default"
                }
            }
            var mirrorSubjectType: String { return "" }
        }
        
        BundleInformation.infoDictionaryManager = CustomManager()
        BundleInformation.mirrorManager = CustomManager()
        
        XCTAssertEqual(BundleInformation.appDisplayName, "")
    }
    
    func testMirrorSubjectTypeString2() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable, MirrorSubjectTypeGettable {
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return nil
                default:                    return "default"
                }
            }
            var mirrorSubjectType: String { return "XXX" }
        }
        
        BundleInformation.infoDictionaryManager = CustomManager()
        BundleInformation.mirrorManager = CustomManager()
        
        XCTAssertEqual(BundleInformation.appDisplayName, "XXX")
    }
    
    func testMirrorSubjectTypeString3() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable, MirrorSubjectTypeGettable {
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return nil
                default:                    return "default"
                }
            }
            var mirrorSubjectType: String { return "XXX.YYY" }
        }
        
        BundleInformation.infoDictionaryManager = CustomManager()
        BundleInformation.mirrorManager = CustomManager()
        
        XCTAssertEqual(BundleInformation.appDisplayName, "XXX")
    }
    
    func testMirrorSubjectTypeString4() {
        struct CustomManager: ObjectForInfoDictionaryKeyGettable, MirrorSubjectTypeGettable {
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
                switch key {
                case "CFBundleDisplayName": return nil
                case "CFBundleName":        return nil
                default:                    return "default"
                }
            }
            var mirrorSubjectType: String { return "XXX.YYY.ZZZ" }
        }
        
        BundleInformation.infoDictionaryManager = CustomManager()
        BundleInformation.mirrorManager = CustomManager()
        
        XCTAssertEqual(BundleInformation.appDisplayName, "XXX.YYY")
    }
    
    func testVersionNil() {
        struct ObjectManager: ObjectForInfoDictionaryKeyGettable {
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
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
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
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
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
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
            func objectForInfoDictionaryKey(key: String) -> AnyObject? {
                switch key {
                case "CFBundleVersion": return "2.3"
                default:                return "default"
                }
            }
        }
        BundleInformation.infoDictionaryManager = ObjectManager()
        XCTAssertEqual(BundleInformation.build, "2.3")
    }
}
