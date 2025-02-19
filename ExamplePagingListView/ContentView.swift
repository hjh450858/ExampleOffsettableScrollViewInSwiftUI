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
    
    @State private var offsetText: String = ""
    var body: some View {
        VStack {
//            Text("offset : \(String(format: "%.2f", offset))")
            OffsetLabel(text: $offsetText)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .padding()
                .background(Color.yellow)
            
            // offset 감지하는 스크롤 뷰
            OffsettableScrollView { point in
                // point 변경 시 호출
                offset = point.y
                offsetText = "\(String(format: "%.2f", offset))"
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

/// offset을 보여주는 라벨
struct OffsetLabel: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textColor = .red
        return label
    }
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = "offset: \(text)"
    }
}

//#Preview {
//    ContentView()
//}
