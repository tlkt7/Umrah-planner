//
//  Client.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import OpenAI

enum APIKEYS {
    static let zhanels = "openAI API"
    static let jarasars = "openAI API"
}

@Observable
class Client {
    static let API_TOKEN = APIKEYS.jarasars
    let openAPI = OpenAI(apiToken: API_TOKEN)
    
    func makePrompt(from answers: [String]) -> String {
        return """
Construct me a tour plan to Umrah by these given answers to the questions below:
Make a detailed plan and calculate the expences using currency tenge.
Never use tables.

Question:
When are you planning to make your trip?🗓 Do you have any specific dates in mind?
Answer:
\(answers[0])

Question:
How many people will be traveling with you?👥
Are you going solo, with family, or friends?
\(answers[1])

Question:
What kind of accommodation are you looking for?🏡 Something budget-friendly, mid-range, or perhaps a bit more luxurious?"
Answer:
\(answers[2])

Question:
Do you have any dietary preferences or special requirements for your meals?🍽️
Answer:
\(answers[3])

Question:
How do you prefer to travel?✈️
Are you more into economy options, or would you like to go for business class?
Answer:
\(answers[4])
"""
    }
    
    func giveAnswer() async {
        
        let query = ChatQuery(
            messages: [.init(role: .user, content: "who are you")!],
            model: .gpt4_o_mini
        )
        do {
            let result = try await openAPI.chats(query: query)
            print(result)
        } catch {
            print(error)
        }
    }
    
    func makeChatQuery(from prompt: String) async throws -> String {
        let query = ChatQuery(
            messages: [.init(role: .user, content: prompt)!],
            model: .gpt4_o_mini
        )
        do {
            let result = try await openAPI.chats(query: query)
            print(result)
            return result.choices.first?.message.content?.string ?? ""
        } catch {
            throw error
        }
    }
}
