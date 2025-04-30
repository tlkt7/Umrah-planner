//
//  Question.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import SwiftUI
import SwiftUIIntrospect

struct RecommendationsDestination: Hashable {
    let answers: [String]
}

struct Question: View {
    @EnvironmentObject var navigation: Navigation
    @State private var currentAnswer: String = ""
    @State private var currentId: Int = 1
    
    let content: [QuestionsModel] = QuestionsModel.all
    @State var answers: [String] = []
    
    var body: some View {
        VStack(spacing: 16) {
            TabView(
                selection: $currentId,
                content:  {
                    ForEach(content) { question in
                        VStack(spacing: 16) {
                            Text(question.title)
                                .font(.system(size: 16, weight: .semibold))
                            if let description = question.description {
                                Text(description)
                                .font(.system(size: 14, weight: .medium))
                            }
                            
                            HStack {
                                TextField(text: $currentAnswer) {
                                    Text("Answer")
                                }
                                Button {
                                    if !currentAnswer.isEmpty {
                                        giveAnswer()
                                    }
                                } label: {
                                    if !currentAnswer.isEmpty {
                                        Image(.arrowBlue)
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                    } else {
                                        Image(.arrowGray)
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                    }
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .overlay(
                                content: {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(.textfieldStroke))
                            })
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 8)
                        }
                        .foregroundColor(Color(.greenAccent))
                        .tag(question.id)
                    }
                    .scrollDisabled(true)
                    .padding(.horizontal, 16)
                }
            )
            .introspect(
                .scrollView,
                on: .iOS(.v17, .v18),
                customize: {
                scrollView in
                scrollView.isScrollEnabled = false
            })
            .animation(.default, value: currentId)
            .multilineTextAlignment(.center)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbarRole(.editor)
            .onKeyPress(.return) {
                giveAnswer()
                return .handled
            }
            .navigationDestination(for: RecommendationsDestination.self) { recommendation in
                Recommendations(answers: recommendation.answers)
            }
        }
    }
    
    private func giveAnswer() {
        if currentId == 6 {
            navigation.navigationPath.append(RecommendationsDestination(answers: answers))
            return
        }
        if currentId < 6 {
            withAnimation {
                answers.append(currentAnswer)
                currentId += 1
            }
        }
        currentAnswer = ""
    }
}

#Preview {
    Question()
        .environmentObject(Navigation())
}
