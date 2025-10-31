//
//  BaseTextView.swift
//  Library App
//
//  Created by Владимир Царь on 23.10.2025.
//

import SwiftUI

struct BaseTextView: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .submitLabel(.done)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .padding(.horizontal, 10)
            .background(.appDark)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
    }
}
