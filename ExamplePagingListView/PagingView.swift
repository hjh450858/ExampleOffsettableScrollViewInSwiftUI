//
//  PagingView.swift
//  ExamplePagingListView
//
//  Created by 황재현 on 2/19/25.
//

import SwiftUI

struct ListPagingWithGeometryReader: View {
    // 초기 데이터
    @State private var items: [Int] = Array(1...20)
    // 로딩 여부
    @State private var isLoading = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Text("Item \(item)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // 페이징 감지용 GeometryReader 추가
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.frame(in: .global).minY) { newValue in
                            print("newValue = \(newValue)")
                            // 리스트 끝 부분 감지
                            if newValue < UIScreen.main.bounds.height {
                                loadMoreItems()
                            }
                        }
                }
                .frame(height: 50)
                
                if isLoading {
                    // 로딩 인디케이터
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
    }
    
    // 데이엩 추가
    func loadMoreItems() {
        // 중복 요청 방지
        guard !isLoading else { return }
        
        isLoading = true
        // 네트워크 요청 시뮬레이션
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let moreItems = items.count+1...items.count+20
            items.append(contentsOf: moreItems)
            isLoading = false
        }
    }
}



/// 페이징 뷰
//struct PagingView: View {
//    /// 아이템
//    @State private var items: [Int] = Array(0..<20)
//    /// 위치
//    @State private var offset: CGFloat = 0
//    /// 로딩 여부
//    @State private var isLoading: Bool = false
//    
//    var body: some View {
//        VStack {
//            contentView
//        }
//    }
//    
//    var contentView: some View {
//        VStack {
//            // offset 감지하는 스크롤 뷰
//            OffsettableScrollView { point in
//                // point 변경 시 호출
//                offset = point.y
//                print("offset = \(offset)")
//            } content: {
//                LazyVStack {
//                    ForEach(items, id: \.self) { item in
//                        Text("Row number \(item)")
//                            .padding()
//                    }
//                }
//            }
//            // 로딩
//            if isLoading {
//                ProgressView()
//                    .padding(.bottom, 20)
//            }
//        }
//    }
//    
//    
//    func addData() {
//        items.append(contentsOf: Array(items.count..<items.count+20))
//    }
//}

//#Preview {
//    PagingView()
//}
