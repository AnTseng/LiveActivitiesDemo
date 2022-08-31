//
//  ContentView.swift
//  LiveActivities
//
//  Created by cm0675 on 2022/8/27.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    let helper: LiveActivityHelper = LiveActivityHelper()
    
    var body: some View {
        NavigationView {
            ZStack {
                //bgImage
                actionButtons
            }
            .onTapGesture {
                helper.showAllRank()
            }
            .navigationTitle("Rank 📊")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("For Apple Developers").bold()
//                        .onTapGesture {
//                            startPizzaAd()
//                        }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    var actionButtons: some View {
        VStack(spacing:0) {
            //Spacer()
            
            HStack(spacing:0) {
                Button(action: { helper.startRanking() }) {
                    HStack {
                        Spacer()
                        Text("Start Rank 🤘🏼").font(.headline)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.blue)
                Button(action: { helper.updateRanking() }) {
                    HStack {
                        Spacer()
                        Text("Update Rank 🫠").font(.headline)
                        Spacer()
                    }.frame(height: 60)
                }.tint(.purple)
            }.frame(maxWidth: UIScreen.main.bounds.size.width)
            
            Button(action: { helper.endRanking() }) {
                HStack {
                    Spacer()
                    Text("Cancel Rank 😞").font(.headline)
                    Spacer()
                }.frame(height: 50)
                .padding(.bottom)
            }.tint(.pink)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 0))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
