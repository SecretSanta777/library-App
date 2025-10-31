//
//  AddBookViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import SwiftUI

enum NavDirection {
    case back
    case forward(String)
}

struct AddBookViewContent: View {
    @State var bookName: String = ""
    @State var isLoading: Bool = false
    
    var competion: (NavDirection) -> Void
    
    var body: some View {
        VStack {
            NavHeader(title: "Добавить книгу") {
                competion(.back)
            }
            
            Spacer()
            
            BaseTextView(placeholder: "название книги", text: $bookName)
            
            Spacer()
            
            Button {
                withAnimation {
                    startLoading()
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 19)
                } else {
                    Text("Далее")
                        .padding(.vertical, 19)
                        .frame(maxWidth: .infinity)
                        .background(.appOrange)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .font(type: .bold, size: 14)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 30)
        .background(.bgMain)
        .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        .onDisappear {
                    isLoading = false
                }
    }
    
    private func startLoading() {
        isLoading = true
        competion(.forward(bookName))
    }
    
}

struct PreviewProvider_AddBookViewContent: PreviewProvider {
    static var previews: some View {
        AddBookViewContent { back in
            //
        }
    }
}

