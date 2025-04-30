//
//  FinalReport.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import Foundation
import SwiftUI

struct FinalReportDestination: Hashable {
    let answer: String
}

struct FinalReport: View {
    let answer: String
    @State private var attrString: AttributedString = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Final report")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(attrString)
            }
            .padding()
            .foregroundStyle(.greenAccent)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .task {
            attrString = makeAttributedString(from: answer)
        }
    }

    func makeAttributedString(from response: String) -> AttributedString {
        var attributedString = AttributedString(response)
        var mutableString = NSMutableAttributedString(attributedString)
        
        // Helper function to apply attributes and remove formatting symbols
        func applyAttributesAndClean(_ pattern: String, attributes: [NSAttributedString.Key: Any]) {
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: mutableString.string, options: [], range: NSRange(location: 0, length: mutableString.length))
            
            for match in matches.reversed() {
                let range = match.range(at: 1)
                mutableString.addAttributes(attributes, range: range)
                
                // Remove formatting symbols
                mutableString.replaceCharacters(in: NSRange(location: match.range.location, length: 1), with: "")
                mutableString.replaceCharacters(in: NSRange(location: match.range.location + match.range.length - 2, length: 1), with: "")
            }
        }
        
        // Bold
        applyAttributesAndClean("\\*\\*(.*?)\\*\\*", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        
        // Italics
        applyAttributesAndClean("\\*(.*?)\\*", attributes: [.font: UIFont.italicSystemFont(ofSize: 16)])
        
        // Strikethrough
        applyAttributesAndClean("~~(.*?)~~", attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        // Code
        applyAttributesAndClean("`(.*?)`", attributes: [
            .font: UIFont(name: "Courier", size: 16)!,
            .backgroundColor: UIColor.gray.withAlphaComponent(0.2)
        ])
        
        // Header
        let headerPattern = "### (.*?)(\\n|$)"
        let headerRegex = try! NSRegularExpression(pattern: headerPattern)
        let headerMatches = headerRegex.matches(in: mutableString.string, range: NSRange(location: 0, length: mutableString.length))
        
        for match in headerMatches.reversed() {
            let range = match.range(at: 1)
            mutableString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 24)], range: range)
            
            // Remove the '### ' part
            mutableString.replaceCharacters(in: NSRange(location: match.range.location, length: 4), with: "")
        }
        
        attributedString = AttributedString(mutableString)
        return attributedString
    }
}

#Preview {
    FinalReport(answer: "Final report details")
}
