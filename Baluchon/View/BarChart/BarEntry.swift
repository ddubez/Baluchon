//
//  BarEntry.swift
//  Baluchon
//
//  Created by David Dubez on 08/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
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
