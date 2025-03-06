//
//  MealBundle.swift
//  Meal
//
//  Created by JoonHyun Cho on 3/6/25.
//

import WidgetKit
import SwiftUI

@main
struct MealBundle: WidgetBundle {
    var body: some Widget {
        Meal()
        MealControl()
    }
}
