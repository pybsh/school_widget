//
//  BackgroundIntent.swift
//  BackgroundIntent
//
//  Created by JoonHyun Cho on 3/8/25.
//

import AppIntents

struct BackgroundIntent: AppIntent {
    static var title: LocalizedStringResource { "BackgroundIntent" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
