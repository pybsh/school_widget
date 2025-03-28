//
//  Timetable.swift
//  Timetable
//
//  Created by JoonHyun Cho on 2/24/25.
//

import WidgetKit
import SwiftUI

private let prefsKeyTimetable = "timetable"
private let prefsKeySchoolInfo = "user_school_info"
private let prefsKeyBgColor = "bgColor"
private let prefsKeyDtColor = "dtColor"
private let prefsKeyMtColor = "mtColor"
private let prefsKeyGrade = "grade"
private let prefsKeyClass_ = "class"
private let widgetGroupId = "group.me.pybsh"

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> TimetableEntry {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let timetable = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        let bgColor = Color(hex: prefs?.string(forKey: prefsKeyBgColor) ?? "FF1F1E33")
        let dtColor = Color(hex: prefs?.string(forKey: prefsKeyDtColor) ?? "FFFFD700")
        let mtColor = Color(hex: prefs?.string(forKey: prefsKeyMtColor) ?? "FFFFFFFF")
        
        return TimetableEntry(date: Date(), timetable: timetable, bgColor: bgColor, dtColor: dtColor, mtColor: mtColor)
    }

    func getSnapshot(in context: Context, completion: @escaping (TimetableEntry) -> ()) {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let timetable = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        let bgColor = Color(hex: prefs?.string(forKey: prefsKeyBgColor) ?? "FF1F1E33")
        let dtColor = Color(hex: prefs?.string(forKey: prefsKeyDtColor) ?? "FFFFD700")
        let mtColor = Color(hex: prefs?.string(forKey: prefsKeyMtColor) ?? "FFFFFFFF")
        
        let entry = TimetableEntry(date: Date(), timetable: timetable, bgColor: bgColor, dtColor: dtColor, mtColor: mtColor)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
                    let timeline = Timeline(entries: [entry], policy: .never)
                    completion(timeline)
                }
//        var entries: [TimetableEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = TimetableEntry(date: Date(), timetable: "1.asd\n2.dsa")
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct TimetableEntry: TimelineEntry {
    let date: Date
    let timetable: String
    let bgColor: Color
    let dtColor: Color
    let mtColor: Color
}

struct TimetableEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.bgColor
            ZStack(alignment: .top) {
                Button(
                    intent: BackgroundIntent(
                        url: URL(string: "schoolWidget://reload"), appGroup: widgetGroupId)
                ) {
                    Image(systemName: "arrow.clockwise.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.gray)
                }
                .buttonStyle(.plain)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(-8.0)
            VStack {
                Text(formatDate(entry.date))
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(entry.dtColor)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(entry.timetable.description)
                    .foregroundColor(entry.mtColor)
                    .font(.system(size: 12, design: .rounded))
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "[MM/dd] 시간표🗓️"
            return formatter.string(from: date)
        }
}

struct Timetable: Widget {
    let kind: String = "Timetable"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TimetableEntryView(entry: entry)
                    .containerBackground(entry.bgColor, for: .widget)
            } else {
                TimetableEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Timetable 시간표")
        .description("Timetable Widget. 시간표 위젯입니다.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    Timetable()
} timeline: {
    TimetableEntry(date: .now, timetable: "-", bgColor: Color(hex: "FF1F1E33"), dtColor: Color.yellow, mtColor: Color.white)
}
