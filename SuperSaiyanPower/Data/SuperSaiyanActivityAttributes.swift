//
//  SuperSaiyanActivityAttributes.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 2/12/23.
//

import Foundation
import ActivityKit

struct SuperSaiyanActivityAttributes: ActivityAttributes {
    public typealias SuperSaiyanActivityStatus = ContentState
    var description: String
    
    public struct ContentState: Codable, Hashable {
        var saiyanName: String
        var superSaiyanTimer: ClosedRange<Date>
    }
}
