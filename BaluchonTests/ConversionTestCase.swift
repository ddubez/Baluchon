//
//  ConversionTestCase.swift
//  BaluchonTests
//
//  Created by David Dubez on 29/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import XCTest
@testable import Baluchon

class ConversionTestCase: XCTestCase {

    var conversion: Conversion!

    override func setUp() {
        super.setUp()
        conversion = Conversion()
    }

    func testGivenConversionWayIsNormal_WhenConvertNumberFourWithRateTwo_ThenAmountConvertedShouldBeHeiht() {
        conversion.way = .normal

        conversion.convert(4, rate: 2)

        XCTAssertEqual(conversion.amountConverted, 8)
    }

    func testGivenConversionWayIsReverse_WhenConvertNumberFourWithRateTwo_ThenAmountConvertedShouldBeTwo() {
        conversion.way = .reserse

        conversion.convert(4, rate: 2)

        XCTAssertEqual(conversion.amountConverted, 2)
    }
}
