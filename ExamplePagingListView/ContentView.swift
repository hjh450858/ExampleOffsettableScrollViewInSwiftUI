//
//  ContentView.swift
//  ExamplePagingListView
//
//  Created by 황재현 on 2/17/25.
//

import SwiftUI

// 출처 : https://medium.com/better-programming/swiftui-calculate-scroll-offset-in-scrollviews-c3b121f0b0dc

struct ContentView: View {
    
    // offset
    @State private var offset: CGFloat = 0.0
    
    var body: some View {
        VStack {
            Text("offset : \(String(format: "%.2f", offset))")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
            
            // offset 감지하는 스크롤 뷰
            OffsettableScrollView { point in
                // point 변경 시 호출
                offset = point.y
                print("offset = \(offset)")
            } content: {
                LazyVStack {
                    ForEach(0..<100) { index in
                        Text("Row number \(index)")
                            .padding()
                    }
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
