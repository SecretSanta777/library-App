//
//  MainViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 23.10.2025.
//

import SwiftUI

enum SelectedCategory {
    case willRead
    case didRead
}

struct MainViewContent: View {
    @State var searchField: String = ""
    @State private var selectedCategory: SelectedCategory = .willRead
    
    @ObservedObject var viewModel: MainViewModel
    
    var comletion: (Book?) -> Void
    var body: some View {
        ZStack(alignment: .top) {
            //MARK: Header
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Добрйы день")
                            .font(size: 14)
                        Text(UserDefaults.standard.string(forKey: "name") ?? "Vova")
                            .font(type: .bold, size: 16)
                    }
                    .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        comletion(nil)
                    } label: {
                        HStack {
                            Image(systemName: "book.closed")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 14, height: 14)
                            Text("добавить")
                                .font(size: 14)
                        }
                    }
                    .padding(.vertical, 7)
                    .padding(.horizontal, 14)
                    .background(.appOrange)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
                    
                }
            }
            .padding(.horizontal, 30)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 25) {
                        BaseTextView(placeholder: "Поиск", text: $searchField)
                            .font()
                            .padding(.horizontal, 30)
                        //MARK: Read
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Читаю")
                                .font(type: .bold, size: 22)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 30)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(viewModel.readingBooks) { book in
                                        Button {
                                            withAnimation {
                                                comletion(book)
                                            }
                                        } label: {
                                            CoverFromFileManager(book: book)
                                        }
                                    }
                                    
                                    
                                }
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                    
                    //MARK: WillRead / DidRead
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom, spacing: 26) {
                            Button {
                                withAnimation {
                                    selectedCategory = .willRead
                                }
                            } label: {
                                createButtonText(text: "Прочитать", category: .willRead)
                            }
                            
                            Button {
                                withAnimation {
                                    selectedCategory = .didRead
                                }
                            } label: {
                                createButtonText(text: "Прочитал", category: .didRead)
                            }
                            
                        }
                        
                        if selectedCategory == .willRead {
                            VStack(spacing: 20) {
                                ForEach(viewModel.willReadBooks) { book in
                                    Button {
                                        withAnimation {
                                            comletion(book)
                                        }
                                    } label: {
                                        BookItem(book: book)
                                    }
                                }
                            }
                        } else {
                            VStack(spacing: 20) {
                                ForEach(viewModel.unreadBooks) { book in
                                    Button {
                                        withAnimation {
                                            comletion(book)
                                        }
                                    } label: {
                                        BookItem(book: book)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
            .padding(.top, 70)
        }
        .background(.bgMain)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    @ViewBuilder
    func createButtonText(text: String, category: SelectedCategory) -> some View {
        var condition = selectedCategory == category
        Text(text)
            .font(type: condition ? .black : .bold, size: condition ? 22 : 20)
            .foregroundStyle(condition ? .white : .appGray)
    }
    
}

struct CoverFromFileManager: View {
    var book: Book
    var body: some View {
        if let image = Image.getImage(folderName: book.id!, fileName: "cover.jpeg") {
            image
                .resizable()
                .frame(width: 143, height: 212)
                .clipShape(.rect(cornerRadius: 5))
        } else {
            Image(.book1)
                .resizable()
                .frame(width: 143, height: 212)
                .clipShape(.rect(cornerRadius: 5))
        }
    }
}


//struct PreviewView_MainViewContent: PreviewProvider {
//    static var previews: some View {
//        MainViewContent {
//
//        }
//    }
//}

