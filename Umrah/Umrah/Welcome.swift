//
//  Welcome.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import SwiftUI

struct QuestionsDestination: Hashable {
    
}

struct Welcome: View {
    @EnvironmentObject var navigation: Navigation
    @State private var isInstructionShown: Bool = false
    @State private var areQuestionsPresented: Bool = false
    
    var body: some View {
        VStack {
            if isInstructionShown {
                Instructions()
                    .transition(.opacity)
            } else {
                StartingButton()
            }
        }
        .animation(.default, value: isInstructionShown)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            ZStack {
                Image(.appBackground)
                    .resizable()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                LinearGradient(
                    colors: [.black.opacity(0.2), .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .edgesIgnoringSafeArea(.all)
        )
        .navigationDestination(for: QuestionsDestination.self) { _ in
            Question()
        }
    }
    
    @ViewBuilder
    private func Instructions() -> some View {
        VStack(spacing: 36) {
            VStack(spacing: 12) {
                VStack(spacing: 16) {
                    Text("Instruction")
                        .font(.system(size: 32, weight: .bold))
                    Text("As-salamu aleikum!")
                        .font(.system(size: 24, weight: .semibold))
                }
                
                Text("Please answer us a few questions and we will calculate your trip to \(Text("Umrah").fontWeight(.bold))")
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
            }
            Button("Start") {
                navigation.navigationPath.append(QuestionsDestination())
            }
            .foregroundStyle(.white)
            .font(
                .system(
                    size: 20,
                    weight: .semibold
                )
            )
            .padding(8)
            .padding(.horizontal, 8)
            .overlay {
                Capsule()
                    .stroke(Color(.white))
            }
        }
        .foregroundStyle(.white)
        
    }
    
    @ViewBuilder
    private func StartingButton() -> some View {
        VStack(spacing: 44) {
            VStack(spacing: 16) {
                Text("Our goal is to make the journey of Umrah accessible to all Muslims!")
                    .font(.system(size: 20, weight: .bold))
                Text("Ensuring everyone can experience this blessed pilgrimage.")
                    .font(.system(size: 14, weight: .medium))
            }
            Button {
                isInstructionShown = true
            } label: {
                Text("Visit Umrah")
                    
                    .font(
                        .system(
                            size: 20,
                            weight: .semibold
                        )
                    )
                    .padding(8)
                    .padding(.horizontal, 8)
                    .overlay {
                        Capsule()
                            .stroke(Color(.white))
                    }
            }
        }
        .padding(16)
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    Welcome()
        .environmentObject(Navigation())
}
