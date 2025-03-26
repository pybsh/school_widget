//
//  Meal.swift
//  Meal
//
//  Created by JoonHyun Cho on 3/6/25.
//

import WidgetKit
import SwiftUI

private let prefsKeyTimetable = "meal"
private let prefsKeySchoolInfo = "user_school_info"
private let prefsKeyBgColor = "bgColor"
private let prefsKeyDtColor = "dtColor"
private let prefsKeyMtColor = "mtColor"
private let widgetGroupId = "group.me.pybsh"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MealEntry {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let meal = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        let bgColor = Color(hex: prefs?.string(forKey: prefsKeyBgColor) ?? "FF1F1E33")
        let dtColor = Color(hex: prefs?.string(forKey: prefsKeyDtColor) ?? "FFFFD700")
        let mtColor = Color(hex: prefs?.string(forKey: prefsKeyMtColor) ?? "FFFFFFFF")
        
        return MealEntry(date: Date(), meal: meal, bgColor: bgColor, dtColor: dtColor, mtColor: mtColor)
    }

    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> ()) {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let meal = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        let bgColor = Color(hex: prefs?.string(forKey: prefsKeyBgColor) ?? "FF1F1E33")
        let dtColor = Color(hex: prefs?.string(forKey: prefsKeyDtColor) ?? "FFFFD700")
        let mtColor = Color(hex: prefs?.string(forKey: prefsKeyMtColor) ?? "FFFFFFFF")
        
        let entry = MealEntry(date: Date(), meal: meal, bgColor: bgColor, dtColor: dtColor, mtColor: mtColor)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
                    let timeline = Timeline(entries: [entry], policy: .never)
                    completion(timeline)
                }
//        var entries: [MealEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = MealEntry(date: entryDate, meal: "😀")
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

struct MealEntry: TimelineEntry {
    let date: Date
    let meal: String
    let bgColor: Color
    let dtColor: Color
    let mtColor: Color
}

struct MealEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
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
                Text(entry.meal.description)
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(entry.mtColor)
                    .multilineTextAlignment(.center)
            }
        }
    }
    func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "[MM/dd] 급식🍔"
            return formatter.string(from: date)
        }
}

struct Meal: Widget {
    let kind: String = "Meal"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MealEntryView(entry: entry)
                    .containerBackground(entry.bgColor, for: .widget)
            } else {
                MealEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Meal 급식")
        .description("Meal Widget. 급식 위젯입니다.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    Meal()
} timeline: {
    MealEntry(date: .now, meal: "-",bgColor: Color(hex: "FF1F1E33"), dtColor: Color.yellow, mtColor: Color.white)
}
