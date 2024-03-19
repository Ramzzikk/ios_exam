//
//  DayView.swift
//  exam_19_03
//
//  Created by Рамазан Рахимов on 19.03.2024.
//

import SwiftUI

struct DayView: View {
    var day: Day
    
    var body: some View {
        VStack {
            Text(day.month)
                .font(.system(size: 10, weight: .black, design: .serif))
            Text("\(day.date)")
                .font(.title)
            Text(day.weekDay)
                .font(.caption)
        }
        .padding()
        .frame(width: 100, height: 100)
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}


