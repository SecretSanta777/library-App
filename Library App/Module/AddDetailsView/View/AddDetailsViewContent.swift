//
//  AddDetailsViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import SwiftUI

enum DetailsPageState {
    case back, save
}

struct AddDetailsViewContent: View {
    @State var bookName: String = ""
    @State var isShorPlaceholder = true
    @State var bookCover: UIImage = .book1
    @ObservedObject var viewModel: AddDetailsViewModel
    var book: BookModelItem?
    //var completion: (DetailsPageState) -> Void
    var delegate: AddDetailsViewDelegate?
    @State var isShowPicker = false
    @State var bookCoverType: ImageType
    
    init(book: BookModelItem? = nil, delegate: AddDetailsViewDelegate, viewModel: AddDetailsViewModel) {
        self.book = book
        self._bookName = .init(initialValue: book?.title ?? "")
        self.delegate = delegate
        self.viewModel = viewModel
        self.bookCoverType = .network(book?.cover_i?.description)
        //self.completion = completion
    }
    
    var body: some View {
        VStack {
            NavHeader(title: book?.title ?? "") {
                delegate?.back()
            }
            
            VStack(spacing: 80) {
                BookCover(image: bookCoverType)
                    .frame(width: 130, height: 180)
                    .clipped()
                    .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Button {
                            isShowPicker.toggle()
                        } label: {
                            ZStack() {
                                Circle()
                                    .foregroundStyle(.appStatusThree)
                                    .frame(width: 24, height: 24)
                                Image(systemName: "arrow.trianglehead.clockwise")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.white)
                            }
                            
                        }
                        .offset(x: 6, y: -6)
                        .sheet(isPresented: $isShowPicker) {
                            ImagePickerView(image: $bookCover, isPresented: $isShowPicker) // ← Передаем оба binding
                        }
                        
                    }
                    .onChange(of: bookCover) { oldValue, newValue in
                        bookCoverType = .local(newValue)
                    }
                
                VStack(spacing: 30) {
                    BaseTextView(placeholder: "Название", text: $bookName)
                    
                    HStack(alignment: .top) {
                        
                        TextField("Описание", text: $viewModel.bookDescription, axis: .vertical)
                            .foregroundStyle(.white)
                            .frame(height: 114, alignment: .topLeading)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                        
                        Button {
                            delegate?.createText()
                        } label: {
                            Image(systemName: "macbook")
                                .resizable()
                                .scaledToFill()
                                .foregroundStyle(.white)
                                .frame(width: 21, height: 21)
                                .padding(.trailing, 16)
                                .padding(.top, 16)
                        }
                        
                        
                    }
                    .background(.appDark)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            
            Spacer()
            
            OrangeButton(title: "Добавить") {
                delegate?.saveBook(image: bookCoverType, bookDescription: viewModel.bookDescription, bookName: bookName, authorName: book?.author_name?.first ?? "")
            }
            .disabled(viewModel.bookDescription.count < 3 && bookName.count < 3 ? true : false)
            .opacity(viewModel.bookDescription.count < 3 && bookName.count < 3 ? 0.5 : 1)
            
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: .top))
        .background(.bgMain)
        .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        .alert(isPresented: $viewModel.isAddError) {
            Alert(title: Text("Ошибка"), message: Text("При сохранении обложки. Добавьте свою обложку или выберите другую книгу"), dismissButton: .default(Text("ok")))
        
        }
    }
}

struct PreviewProvider_AddDetailsViewContent: PreviewProvider {
    static var previews: some View {
        AddDetailsViewContent(delegate: AddDetailsView(), viewModel: AddDetailsViewModel())
    }
}
