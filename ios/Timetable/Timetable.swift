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
private let prefsKeyGrade = "grade"
private let prefsKeyClass_ = "class"
private let widgetGroupId = "group.me.pybsh"

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> TimetableEntry {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let timetable = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        
        return TimetableEntry(date: Date(), timetable: timetable)
    }

    func getSnapshot(in context: Context, completion: @escaping (TimetableEntry) -> ()) {
        let prefs = UserDefaults(suiteName: widgetGroupId)
        let timetable = prefs?.string(forKey: prefsKeyTimetable) ?? "-"
        
        let entry = TimetableEntry(date: Date(), timetable: timetable)
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
}

struct TimetableEntryView : View {
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
                }
                .buttonStyle(.plain)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            Text(entry.timetable.description)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
}

struct Timetable: Widget {
    let kind: String = "Timetable"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TimetableEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TimetableEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Timetable")
        .description("This is an timetable widget.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    Timetable()
} timeline: {
    TimetableEntry(date: .now, timetable: "-")
    TimetableEntry(date: .now, timetable: "-")
}
