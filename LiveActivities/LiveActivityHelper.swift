//
//  LiveActivityHelper.swift
//  LiveActivities
//
//  Created by cm0675 on 2022/8/28.
//

import Foundation
import ActivityKit

class LiveActivityHelper {
    
    var rankActivity: Activity<StockRankAttributes>?
    
    // MARK: - Functions
    func startRanking() {
        let stockList: [Stock] = [
            Stock(stockKey: "2330", stockName: "台積電", price: 512, change: 4, changeRate: 0.79),
            Stock(stockKey: "5213", stockName: "亞昕", price: 22.4, change: 0, changeRate: 0),
            Stock(stockKey: "5522", stockName: "遠雄", price: 62.4, change: -0.3, changeRate: -0.48),
            Stock(stockKey: "6514", stockName: "芮特-KY", price: 65.4, change: -0.8, changeRate: -1.21)
        ]
        let attributes = StockRankAttributes()
        let attributesState = StockRankAttributes.ContentState(showTime: Date(), stockList: stockList)
        
        do {
            let pushType: PushType? = nil
            rankActivity = try Activity<StockRankAttributes>.request(
                attributes: attributes,
                contentState: attributesState,
                pushType: pushType)
            guard let rankActivity else {
              print("Error: Could not initialize activity.")
              return
            }
            
            print("Build with ID: \(rankActivity.id) is now pending.")
            if pushType == .token, let pushToken = rankActivity.pushToken {
                print("Push Token: \(pushToken)")
                // 提供 pushToken 給 push notification server, server 會使用它來提供讓Live Activity使用的推播
            }
        } catch (let error) {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateRanking() {
        let stockList: [Stock] = [
            Stock(stockKey: "1524", stockName: "耿鼎", price: 29.25, change: 2.65, changeRate: 9.96),
            Stock(stockKey: "2497", stockName: "怡利電", price: 86.4, change: 7.8, changeRate: 9.92),
            Stock(stockKey: "2388", stockName: "威盛", price: 83.3, change: 7.5, changeRate: 9.89),
            Stock(stockKey: "2303", stockName: "聯電", price: 41.3, change: -0.1, changeRate: -0.24)
        ]
        Task {
            let update = StockRankAttributes.ContentState(showTime: Date(), stockList: stockList)
            for activity in Activity<StockRankAttributes>.activities{
                await activity.update(using: update)
            }
        }
    }
    
    func showAllRank() {
        Task {
            for activity in Activity<StockRankAttributes>.activities {
                print("Pizza delivery details: \(activity.id) -> \(activity.attributes)")
            }
        }
    }
    
    func endRanking() {
        Task {
            for activity in Activity<StockRankAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
                //await activity.end(dismissalPolicy: .default)
            }
        }
    }
}
