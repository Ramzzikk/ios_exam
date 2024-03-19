//
//  ContentView.swift
//  exam_19_03
//
//  Created by Рамазан Рахимов on 19.03.2024.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @ObservedObject var calendarManager = CalendarManager()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { scrollView in
                LazyVStack {
                    // Невидимый маркер начала
                    Color.clear.frame(height: 0.1)
                        .id("start")
                        .onAppear {
                            // Переход к концу списка (конец 2025 года)
                            withAnimation {
                                scrollView.scrollTo("end", anchor: .bottom)
                            }
                        }
                    
                    ForEach(calendarManager.weeks, id: \.self) { week in
                        WeekView(week: week)
                    }
                    
                    // Невидимый маркер конца
                    Color.clear.frame(height: 0.1)
                        .id("end")
                        .onAppear {
                            // Переход к началу списка (начало 2023 года)
                            withAnimation {
                                scrollView.scrollTo("start", anchor: .top)
                            }
                        }
                }
            }
        }
    }
}

// MARK: - ContentView Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - ScrollView Extension for Offset Detection

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ScrollViewOffsetModifier: ViewModifier {
    var onOffsetChange: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: proxy.frame(in: .named("scrollView")).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: onOffsetChange)
    }
}

extension View {
    func onScrollViewOffsetChange(_ onOffsetChange: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(ScrollViewOffsetModifier(onOffsetChange: onOffsetChange))
    }
}
