//
//  ActivityAttributes.swift
//  LiveActivities
//
//  Created by cm0675 on 2022/8/28.
//

import Foundation
import ActivityKit

struct Stock: Codable, Identifiable, Hashable {
    var id = UUID()
    
    var stockKey: String
    
    var stockName: String
    
    var price: Double
    
    var change: Double
    
    var changeRate: Double
}

struct StockRankAttributes: ActivityAttributes {
    
    typealias StockRankStatus = ContentState
    
    struct ContentState: Codable, Hashable {
        var showTime: Date
        var stockList: [Stock]
    }
}
