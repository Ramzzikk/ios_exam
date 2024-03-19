//
//  WeekView.swift
//  exam_19_03
//
//  Created by Рамазан Рахимов on 19.03.2024.
//

import SwiftUI

struct WeekView: View {
    var week: Week
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Week \(week.number) of \(week.year)")
                .font(.headline)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(week.days, id: \.self) { day in
                        DayView(day: day)
                    }
                }
            }
        }
    }
}


