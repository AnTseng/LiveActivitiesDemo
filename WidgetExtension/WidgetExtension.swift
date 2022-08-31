//
//  WidgetExtension.swift
//  LiveActivities
//
//  Created by cm0675 on 2022/8/28.
//

import WidgetKit
import SwiftUI
import Intents

//@main
//struct Widgets: WidgetBundle {
//    var body: some Widget {
//        RankActivityWidget()
//    }
//}

@main
struct RankActivityWidget: Widget {
    let kind: String = "WidgetExtension"
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(attributesType: StockRankAttributes.self) { context in
            RankView(stockList: context.state.stockList)
        }
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        let stockList: [Stock] = [
            Stock(stockKey: "2330", stockName: "台積電", price: 512, change: 4, changeRate: 0.79),
            Stock(stockKey: "5213", stockName: "亞昕", price: 22.4, change: 0, changeRate: 0),
            Stock(stockKey: "5522", stockName: "遠雄", price: 62.4, change: -0.3, changeRate: -0.48),
            Stock(stockKey: "6514", stockName: "芮特-KY", price: 65.4, change: -0.8, changeRate: 1.21)
        ]
        
        RankView(stockList: stockList)
            .previewContext(
                WidgetPreviewContext(
                    family: .systemMedium
                )
            )
    }
}

struct RankView: View {
    @State var stockList: [Stock]
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 0) {
                TopView().padding(.top, 0)
                BottomView(stockList: stockList)
                Spacer()
            }
            .activitySystemActionForegroundColor(Color.cyan)
        }
    }
}

struct TopView: View {
    var body: some View {
        HStack {
            Image("LOGO")
                .frame(width: 25, height: 25)
            Spacer()
            Text("漲幅排行榜")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(height: 30)
        .background(Color(hex: "C2292E"))
    }
}

struct BottomView: View {
    @State var stockList: [Stock]
    
    var body: some View {
        VStack {
            ForEach(stockList) { stock in
                RankCellView(stock: stock)
                    .frame(height: 25)
            }
        }
    }
}

struct RankCellView: View {
    @State var stock: Stock
    
    var color: Color {
        if stock.changeRate > 0 {
            return Color(hex: "DC1D24")
        } else if stock.changeRate == 0 {
            return Color(hex: "323A3C")
        }
        
        return Color(hex: "238D12")
    }
    
    var change: String {
        let change: String = String(stock.change)
        if stock.change > 0 {
            return "▲" + change
        } else if stock.change == 0 {
            return "-"
        }
        return "▼" + change
    }
    
    var changeRate: String {
        let rate: String = String(stock.changeRate) + "%"
        if stock.changeRate > 0 {
            return "+" + rate
        } else if stock.changeRate == 0 {
            return "-"
        }
        return rate
    }
    
    var body: some View {
        HStack {
            Text(stock.stockKey)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "323A3C"))
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text(stock.stockName)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "323A3C"))
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text(String(stock.price))
                .font(.system(size: 14))
                .foregroundColor(color)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text(change)
                .font(.system(size: 14))
                .foregroundColor(color)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Text(changeRate)
                .font(.system(size: 14))
                .foregroundColor(color)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
    }
}
