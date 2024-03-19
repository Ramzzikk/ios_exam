import Foundation

class CalendarManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var weeks = [Week]()
    
    // MARK: - Initialization
    
    init() {
        prepareDataForThreeYears()
    }
    
    // MARK: - Year and Date Calculation Methods
    
    func isLeapYear(year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    func daysInMonth(month: Int, year: Int) -> Int {
        switch month {
        case 2:
            return isLeapYear(year: year) ? 29 : 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 31
        }
    }
    // MARK: - Data Preparation
    func prepareDataForThreeYears() {
        weeks.removeAll()
        let currentYear = Calendar.current.component(.year, from: Date())
        // Генерируем данные начиная с прошлого года и на два года вперед
        let years = [currentYear - 1, currentYear, currentYear + 1]
        
        for year in years {
            for month in 1...12 {
                let daysCount = daysInMonth(month: month, year: year)
                for day in 1...daysCount {
                    let dateComponents = DateComponents(year: year, month: month, day: day)
                    let date = Calendar.current.date(from: dateComponents)!
                    let weekOfYear = Calendar.current.component(.weekOfYear, from: date)
                    let weekday = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
                    
                    let dayModel = Day(date: day, month: Calendar.current.monthSymbols[month - 1], weekDay: weekday)
                    
                    if let weekIndex = weeks.firstIndex(where: { $0.number == weekOfYear && $0.year == year }) {
                        weeks[weekIndex].days.append(dayModel)
                    } else {
                        let weekModel = Week(days: [dayModel], number: weekOfYear, year: year)
                        weeks.append(weekModel)
                    }
                }
            }
        }
    }
}

     // MARK: - Models

struct Day: Identifiable, Hashable {
    var id = UUID()
    var date: Int
    var month: String
    var weekDay: String
}

struct Week: Identifiable, Hashable {
    var id = UUID()
    var days: [Day]
    var number: Int
    var year: Int
}

