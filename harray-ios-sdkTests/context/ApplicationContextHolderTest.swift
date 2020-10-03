//
//  ApplicationContextHolderTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class ApplicationContextHolderTest: XCTestCase {

    func test_it_should_initialize_persistent_id_when_persistent_id_is_not_present_in_user_defaults(){
        let userDefaults = NotInitializedUserDefaults()
        RandomValueUtils.freeze()
        let applicationContextHolder = ApplicationContextHolder(userDefaults: userDefaults)
        let persistentId = RandomValueUtils.randomUUID()
        
        XCTAssertEqual(persistentId, userDefaults.value as? String)
        XCTAssertEqual(Constants.SDK_PERSISTENT_ID_KEY.rawValue, userDefaults.keyValue)
        XCTAssertEqual(persistentId, applicationContextHolder.getPersistentId())
        XCTAssertTrue(applicationContextHolder.isNewInstallation())
        
        RandomValueUtils.unFreeze()
    }
    
    func test_it_should_return_persistent_id_when_persistent_id_is_present_in_shared_preferences() {
        let userDefaults = InitializedUserDefaults()
      
        let applicationContextHolder = ApplicationContextHolder(userDefaults: userDefaults)
        XCTAssertNil(userDefaults.value)
        XCTAssertEqual("stored-persistent-id", applicationContextHolder.getPersistentId())
    }
    
    func test_it_should_return_time_zone(){
        let userDefaults = InitializedUserDefaults()
             
        let applicationContextHolder = ApplicationContextHolder(userDefaults: userDefaults)
        XCTAssertEqual("0", applicationContextHolder.getTimezone())
    }
    
    func test_it_should_set_installation_completed_when_invoked(){
        let userDefaults = InitializedUserDefaults()
      
        let applicationContextHolder = ApplicationContextHolder(userDefaults: userDefaults)
        applicationContextHolder.setInstallationCompleted()
        
        XCTAssertFalse(applicationContextHolder.isNewInstallation())
        
    }
}
