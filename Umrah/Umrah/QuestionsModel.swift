//
//  QuestionsModel.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import SwiftUI

struct QuestionsModel: Identifiable {
    let id: Int
    let title: LocalizedStringKey
    let description: LocalizedStringKey?
    
    
    static let all: [QuestionsModel] = [
        .init(
            id: 1,
            title: "When are you planning to make your trip?🗓",
            description: "Do you have any specific dates in mind?"
        ),
        .init(
            id: 2,
            title: "How many people will be traveling with you?👥",
            description: "Are you going solo, with family, or friends?"
        ),
        .init(
            id: 3,
            title: "What kind of accommodation are you looking for?🏡",
            description: "Something budget-friendly, mid-range, or perhaps a bit more luxurious?"
        ),
        .init(
            id: 4,
            title: "Do you have any dietary preferences or special requirements for your meals?🍽️",
            description: nil
        ),
        .init(
            id: 5,
            title: "How do you prefer to travel?✈️ ",
            description: "Are you more into economy options, or would you like to go for business class?"
        ),
        .init(
            id: 6,
            title: "And for local travel, would you prefer shared transportation or something more private?🚍 🚘",
            description: nil
        )
        
    ]
}
