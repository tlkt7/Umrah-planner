//
//  Recommendations.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import SwiftUI
import Lottie

struct Recommendations: View {
    @EnvironmentObject var navigation: Navigation
    @State private var currentId: Int = Int.random(in: 1...5)
    let recommendations: [RecommendationModel] = RecommendationModel.all
    let chatGPT = Client()
    var answers: [String] = []
    var body: some View {
        VStack {
            Text("Did you know?")
                .font(.title)
                .fontWeight(.black)
            ZStack {
                ForEach(recommendations) { recommendation in
                    if currentId == recommendation.id {
                        VStack(spacing: .zero) {
                            LottieView(animation: .named(recommendation.gifName))
                                .playing(loopMode: .loop)
                                .frame(width: 250, height: 250)
                            VStack(spacing: 24) {
                                Text(recommendation.title)
                                    .font(.system(size: 18, weight: .semibold))
                                Text(recommendation.description)
                                    .font(.system(size: 15, weight: .medium))
                            }
                            .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .foregroundStyle(Color(.greenAccent))
        .toolbarRole(.editor)
        .animation(.default, value: currentId)
        .task {
            if answers.count > 4 {
                let prompt = chatGPT.makePrompt(from: answers)
                do {
                    let result = try await chatGPT.makeChatQuery(from: prompt)
                    navigation.navigationPath.append(FinalReportDestination(answer: result))
                } catch {
                    print(error)
                }
            }
        }
        .task {
            for _ in 1..<6 {
                try? await Task.sleep(for: .seconds(5))
                currentId = Int.random(in: 1...5)
            }
        }
        .navigationDestination(for: FinalReportDestination.self) { finalReport in
            FinalReport(answer: finalReport.answer)
        }
    }
}

#Preview {
    Recommendations()
}
