//
//  RegistViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 20.10.2025.
//

import SwiftUI

struct RegistViewContent: View {
    @State var nameField: String = ""
    var btnAction: (String) -> Void
    var body: some View {
        ZStack {
            VStack {
                Text("Добро пожаловать")
                    .font(type: .black, size: 22)
                    .foregroundStyle(.white)
                
                Spacer()
                
                BaseTextView(placeholder: "Ваше имя", text: $nameField)
                
                Spacer()
                
                OrangeButton(title: "Далее") {
                    btnAction(nameField)
                }

            }
            .padding(.horizontal, 30)
        }
        .background(.bgMain)
    }
}

struct PreviewProivider_RegistViewContent: PreviewProvider {
    static var previews: some View {
        RegistViewContent { name in
            print(name)
        }
    }
}

