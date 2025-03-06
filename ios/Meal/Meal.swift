//
//  Meal.swift
//  Meal
//
//  Created by JoonHyun Cho on 3/6/25.
//

import WidgetKit
import SwiftUI

private let prefsKeyTimetable = "meal"
private let widgetGroupId = "group.me.pybsh"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MealEntry {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let meal = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        return MealEntry(date: Date(), meal: meal)
    }

    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> ()) {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let meal = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        
        let entry = MealEntry(date: Date(), meal: meal)
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
}

struct MealEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.meal.description)
        }
    }
}

struct Meal: Widget {
    let kind: String = "Meal"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MealEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MealEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Meal")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    Meal()
} timeline: {
    MealEntry(date: .now, meal: "😀")
    MealEntry(date: .now, meal: "🤩")
}
