//
//  BarEntry.swift
//  Baluchon
//
//  Created by David Dubez on 08/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//
//  Based on : BarChart
//      Created by Nguyen Vu Nhat Minh on 19/8/17.
//      Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//      BarChart is available under the MIT license. See the LICENSE file for more info.
//      https://github.com/nhatminh12369/BarChart
//

import Foundation
import UIKit

struct BarEntry {
    let color: UIColor

    /// Ranged from 0.0 to 1.0
    let height: Float

    /// To be shown on top of the bar
    let textValue: String

    /// To be shown at the bottom of the bar
    let title: String
}
