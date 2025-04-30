//
//  RecommendationModel.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import SwiftUI

struct RecommendationModel: Identifiable {
    let id: Int
    let gifName: String
    let title: LocalizedStringKey
    let description: LocalizedStringKey
    
    static let all: [RecommendationModel] = [
        .init(
            id: 1,
            gifName: "recommendation-1",
            title: "Before embarking on your journey for Umrah,",
            description: "Ensure that your intentions are pure and that you are undertaking this pilgrimage sincerely for the sake of Allah."
        ),
        .init(
            id: 2,
            gifName: "recommendation-2",
            title: "Familiarize yourself with the local customs and traditions",
            description: "Be mindful that the culture and traditions of Saudi Arabia may differ from what you are accustomed to. For instance, adhere to the rules regarding dress code and behavior in public spaces"
        ),
        .init(
            id: 3,
            gifName: "recommendation-3",
            title: "Knowledge of the locations",
            description: "Be aware of the sacred sites you will visit and which prayers and supplications are most appropriate for each. This will help you approach each stage of Umrah with greater mindfulness"
        ),
        .init(
            id: 4,
            gifName: "recommendation-4",
            title: "Prayers and supplications",
            description: "Prepare to engage in additional prayers and supplications during your time in the holy sites. Pay special attention to praying for yourself and your loved ones"
        ),
        .init(
            id: 5,
            gifName: "recommendation-5",
            title: "Adhere to the rules of decorum and respect",
            description: "Be mindful of your behavior in the holy sites. Show respect and kindness to fellow pilgrims and local residents"
        )
    ]
}
