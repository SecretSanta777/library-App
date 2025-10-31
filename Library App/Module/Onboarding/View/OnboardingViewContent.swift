//
//  OnboardingViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 21.10.2025.
//

import SwiftUI

struct OnboardingViewContent: View {
    var slides: [OnboardingViewData]
    var comletion: () -> Void
    @State var selected: Int = 0
    @State var btnText: String = "Далее"
    var body: some View {
        VStack {
            Text("Добро пожаловать")
                .font(type: .black, size: 22)
                .foregroundStyle(.white)
            
            Spacer()
            
            VStack {
                TabView(selection: $selected) {
                    
                    ForEach(0..<slides.count, id: \.self) { slide in
                        SlideItem(tag: slide, item: slides[slide])
                            .padding(.horizontal, 30)
                        
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<slides.count, id: \.self) { slide in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(slide == selected ? .appOrange : .white)
                            .onTapGesture {
                                withAnimation {
                                    selected = slide
                                }
                            }
                    }
                }
            }
            .frame(height: 400)
            .onChange(of: selected) { oldValue, newValue in
                withAnimation {
                    if newValue == slides.count - 1 {
                        btnText = "Начать пользоваться"
                    } else {
                        btnText = "Далее"
                    }
                }
            }
            
            Spacer()
            
            OrangeButton(title: btnText) {
                if selected < slides.count - 1 {
                    withAnimation {
                        selected += 1
                    }
                } else {
                    withAnimation {
                        print("next")
                        comletion()
                    }
                }
            }
            .padding(.horizontal, 30)
        }
        .background(.bgMain)
    }
}

struct PreviewProvider_OnboardingViewContent: PreviewProvider {
    static var previews: some View {
        OnboardingViewContent(slides: OnboardingViewData.mockData) {
            
        }
    }
}

struct SlideItem: View {
    var tag: Int
    var item: OnboardingViewData
    var body: some View {
        VStack(spacing: 39) {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipped()
            Text(item.description)
                .font(size: 16)
                .foregroundStyle(.white)
        }
        .tag(tag)
    }
}
