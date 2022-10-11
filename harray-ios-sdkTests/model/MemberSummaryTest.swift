//
//  MemberSummaryTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 10/10/22.
//  Copyright © 2022 xennio. All rights reserved.
//

import XCTest

final class MemberSummaryTest: XCTestCase {

    func test_it_should_return_nil_when_json_response_not_suitable() {
        let jsonResponse = ""
        let jsonDeserializer = JsonDeserializerService()
        
        let memberSummary: MemberSummary? = jsonDeserializer.deserialize(jsonString: jsonResponse)
        XCTAssertNil(memberSummary)
    }
    
    func test_it_should_return_member_summary_details_when_json_response_ok() {
        let jsonResponse = "{\"member\":{\"id\":\"3207340\",\"name\":\"Mobile\",\"surname\":\"Test\",\"lastSeen\":\"2022-10-21T05:47:25Z\",\"registerDate\":\"2022-01-06T11:12:09Z\",\"segments\":[\"Kurumsal\"],\"notificationPermissions\":{\"commercial\":{\"sms\":true,\"email\":true},\"commercialThirdParty\":{\"sms\":true,\"email\":true}}},\"ratios\":[{\"attribute\":\"city\",\"values\":[{\"key\":\"Balıkesir\",\"value\":0.27},{\"key\":\"Ankara\",\"value\":0.13},{\"key\":\"İstanbul\",\"value\":0.17},{\"key\":\"Sakarya\",\"value\":0.2},{\"key\":\"Aydın\",\"value\":0.07},{\"key\":\"İzmir\",\"value\":0.03},{\"key\":\"K.K.T.C.\",\"value\":0.1},{\"key\":\"Kayseri\",\"value\":0.03}]},{\"attribute\":\"intent\",\"values\":[{\"key\":\"Konut Satılık\",\"value\":1.0}]},{\"attribute\":\"county\",\"values\":[{\"key\":\"Beşiktaş\",\"value\":0.03},{\"key\":\"Karasu\",\"value\":0.2},{\"key\":\"Keçiören\",\"value\":0.03},{\"key\":\"Maltepe\",\"value\":0.03},{\"key\":\"Avcılar\",\"value\":0.03},{\"key\":\"Aliağa\",\"value\":0.03},{\"key\":\"Lefkoşa\",\"value\":0.03},{\"key\":\"Sındırgı\",\"value\":0.03},{\"key\":\"Girne\",\"value\":0.03},{\"key\":\"Lefke\",\"value\":0.03},{\"key\":\"Didim\",\"value\":0.03},{\"key\":\"Kadıköy\",\"value\":0.03},{\"key\":\"Edremit\",\"value\":0.23},{\"key\":\"Çankaya\",\"value\":0.1},{\"key\":\"Kuşadası\",\"value\":0.03},{\"key\":\"Tuzla\",\"value\":0.03},{\"key\":\"Develi\",\"value\":0.03}]},{\"attribute\":\"roomInfo\",\"values\":[{\"key\":\"1+1\",\"value\":0.07},{\"key\":\"4+1\",\"value\":0.2},{\"key\":\"3+1\",\"value\":0.33},{\"key\":\"2+1\",\"value\":0.4}]},{\"attribute\":\"category\",\"values\":[{\"key\":\"Residence\",\"value\":0.03},{\"key\":\"Daire\",\"value\":0.73},{\"key\":\"Villa\",\"value\":0.2},{\"key\":\"Müstakil Ev\",\"value\":0.03}]},{\"attribute\":\"district\",\"values\":[{\"key\":\"Harman\",\"value\":0.03},{\"key\":\"Yüreğil\",\"value\":0.03},{\"key\":\"Tahtakale\",\"value\":0.03},{\"key\":\"Karşıyaka\",\"value\":0.03},{\"key\":\"Altıntepe\",\"value\":0.03},{\"key\":\"Ovacık\",\"value\":0.03},{\"key\":\"Akçay\",\"value\":0.23},{\"key\":\"Suadiye\",\"value\":0.03},{\"key\":\"Efeler\",\"value\":0.03},{\"key\":\"Aydınlı\",\"value\":0.03},{\"key\":\"Lefke\",\"value\":0.03},{\"key\":\"İlkbahar\",\"value\":0.03},{\"key\":\"Aziziye\",\"value\":0.07},{\"key\":\"Şehit Cevdet Özdemir\",\"value\":0.03},{\"key\":\"Yenikent\",\"value\":0.03},{\"key\":\"Kültür\",\"value\":0.03},{\"key\":\"Yalı\",\"value\":0.13},{\"key\":\"Siteler\",\"value\":0.03},{\"key\":\"Yavansu\",\"value\":0.03},{\"key\":\"Etiler\",\"value\":0.03}]}],\"ranges\":{\"price\":{\"min\":350000.0,\"max\":2.15E7,\"avg\":3178485.47}}}"
        let jsonDeserializer = JsonDeserializerService()
        
        let memberSummary: MemberSummary? = jsonDeserializer.deserialize(jsonString: jsonResponse)
        XCTAssertNotNil(memberSummary)
        XCTAssertEqual(memberSummary!.member?.name, "Mobile")
    }

}
