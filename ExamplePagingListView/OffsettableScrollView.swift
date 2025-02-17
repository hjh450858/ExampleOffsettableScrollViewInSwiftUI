//
//  OffsettableScrollView.swift
//  ExamplePagingListView
//
//  Created by 황재현 on 2/17/25.
//

import SwiftUI


/// Offset 위치를 감지하는 스크롤 뷰
struct OffsettableScrollView<T: View>: View {
    /// 스크롤 방향
    let axes: Axis.Set
    /// 인디케이터 보여줌
    let showsIndicator: Bool
    /// offset 변경
    let onOffsetChanged: (CGPoint) -> Void
    /// 내용
    let content: T
    
    // init
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
         @ViewBuilder content: () -> T) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            // 현재 뷰의 위치를 감지
            GeometryReader { proxy in
                // 투명한 뷰 설정
                // proxy frame(in: .named("ScrollViewOrigin")을 통해 뷰의 위치를 CGPoint로 저장
                Color.clear.preference(key: OffsetPreferenceKey.self,
                                       value: proxy.frame(in: .named("ScrollViewOrigin")).origin)
            }
            // 화면에 표시되지 않도록 설정
            .frame(width: 0, height: 0)
            content
        }
        // "ScrollViewOrigin"이라는 이름의 고유한 좌표 공간을 생성
        // 뷰의 상대적인 위치를 특정 공간을 기준으로 계산 가능
        .coordinateSpace(name: "ScrollViewOrigin")
        // OffswetPreferenceKey값이 변경될때마다 onOffsetChanged 호출
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChanged)
    }
}

// PreferenceKey = SwiftUI에서 뷰 간 데이터 공유를 위해 사용되는 key-value 구조
private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    // 새로운 값이 들어올 때 기존 값을 어떻게 처리할지 정의
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

//#Preview {
//    OffsettableScrollView()
//}
