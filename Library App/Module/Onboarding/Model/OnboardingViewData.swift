//
//  OnboardingViewData.swift
//  Library App
//
//  Created by Владимир Царь on 21.10.2025.
//

import Foundation

struct OnboardingViewData: Identifiable {
    var id: UUID = UUID()
    var image: String
    var description: String
    
    static var mockData: [OnboardingViewData]  {
        [
            OnboardingViewData(image: "book1", description: "Первые книги были свитками. Они появились около 3000 лет до н. э. в Древнем Египте и представляли собой скрепленные папирусные свитки."),
            OnboardingViewData(image: "book2", description: "Книги ценились настолько высоко, что их приковывали цепями. В средневековье книги были редкими и очень дорогими, поэтому для защиты от кражи их часто приковывали к полкам в библиотеках."),
            OnboardingViewData(image: "book3", description: "Самая дорогая книга в мире — «Лестерский кодекс» Леонардо да да Винчи. Его научный дневник был продан на аукционе в 1994 году за $30,8 миллиона.")
        ]
    }
}
