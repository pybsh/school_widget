//
//  TimetableBundle.swift
//  Timetable
//
//  Created by JoonHyun Cho on 2/24/25.
//

import WidgetKit
import SwiftUI

@main
struct TimetableBundle: WidgetBundle {
    var body: some Widget {
        Timetable()
        TimetableControl()
    }
}
