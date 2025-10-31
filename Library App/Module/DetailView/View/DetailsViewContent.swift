//
//  DetailsViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import SwiftUI

struct DetailsViewContent: View {
    @State var bookNote: String = ""
    @State var offsetTop: CGFloat = 0
    @State var showTitle: Bool = false
    @State var commetDeleteOffsetX: CGFloat = 0
    @State private var notes: [Note] = []
    @State private var currentBookStatus: BookStatus
    @FocusState private var isTextFieldFocused: Bool
    
    var book: Book?
    var action: () -> Void
    
    var bookName: String {
        book?.name ?? ""
    }
    
    
    
    init(book: Book?, action: @escaping () -> Void) {
        self.book = book
        self.action = action
        if let book = book {
            _currentBookStatus = State(initialValue: BookStatus(rawValue: book.status) ?? .willRead)
        } else {
            _currentBookStatus = State(initialValue: .willRead)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                Text(showTitle ? bookName : "О книге")
                    .font(size: 18)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button {
                    //
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
            }
            .frame(height: 40)
            .padding(.top, 53)
            .zIndex(1)
            .padding(.horizontal, 30)
            .background(
                .bgMain.opacity(offsetTop < 0 ? (-offsetTop * 20 / 1000) : 0)
            )
            
            ScrollView {
                VStack(spacing: 29) {
                    ZStack(alignment: .top) {
                        GeometryReader { proxy in
                            let minY = proxy.frame(in: .global).minY
                            BookCoverView(book: book!)
                                .scaledToFill()
                                .frame(maxWidth: proxy.size.width)
                                .frame(height: 430 + (minY > 0 ? minY : 0))
                                .clipped()
                                .overlay {
                                    Color.purple.opacity(0.5)
                                }
                                .offset(y: minY > 0 ? -minY : 0)
                                .onChange(of: minY) { oldValue, newValue in
                                    offsetTop = newValue
                                    withAnimation {
                                        if newValue < -100 {
                                            showTitle = true
                                        } else {
                                            showTitle = false
                                        }
                                    }
                                }
                        }
                        .frame(height: 430)
                        
                        VStack(spacing: 15) {
                            CoverFromFileManager(book: book!)
                            
                            VStack(spacing: 2) {
                                Text(bookName)
                                    .font(type: .bold, size: 20)
                                Text(book?.author ?? "")
                                    .font(type: .medium, size: 14)
                            }
                            .foregroundStyle(.white)
                            
                            BookStatusButton(status: $currentBookStatus){
                                changeBookStatus()
                            }
                        }
                        .padding(.top, 95)
                    }
                    
                    VStack(alignment: .leading, spacing: 36) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Описание")
                                .font(type: .black, size: 18)
                                .foregroundStyle(.white)
                            Text(book?.bookDescription ?? "")
                                .font(size: 14)
                                .foregroundStyle(.appGray)
                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Заметки по книге")
                                .font(type: .bold, size: 18)
                                .foregroundStyle(.white)
                            
                            VStack(alignment: .leading, spacing: 14) {
                                // Display all notes
                                ForEach(notes, id: \.id) { note in
                                    CommentView(note: note)
                                        .offset(x: -commetDeleteOffsetX)
                                        .gesture(
                                            DragGesture()
                                                .onChanged({ value in
                                                    if value.translation.width < -commetDeleteOffsetX {
                                                        withAnimation {
                                                            commetDeleteOffsetX = abs(value.translation.width)
                                                        }
                                                    }
                                                })
                                                .onEnded({ value in
                                                    withAnimation {
                                                        if value.translation.width < -100 {
                                                            commetDeleteOffsetX = 150
                                                            // Delete note after swipe
                                                            deleteNote(note)
                                                        } else {
                                                            commetDeleteOffsetX = 0
                                                        }
                                                    }
                                                })
                                        )
                                        .zIndex(1)
                                }
                            }
                            //.frame(maxWidth: .infinity)
                            HStack {
                                BaseTextView(placeholder: "Добавить заметку", text: $bookNote)
                                    .focused($isTextFieldFocused)   
                                Spacer()
                                
                                Button {
                                    addNote()
                                    isTextFieldFocused = false
                                } label: {
                                    Text("Добавить заметку")
                                        .foregroundStyle(.white)
                                        .font(type: .medium, size: 16)
                                        .frame(height: 52)
                                        .padding(.horizontal, 10)
                                        .background(.appOrange)
                                        .clipShape(.rect(cornerRadius: 10))
                                }

                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 15)
            }
        }
        .ignoresSafeArea()
        .background(.bgMain)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear {
            loadNotes()
        }
    }
    
    private func changeBookStatus() {
        guard let book = book else { return }
        
        let nextStatus: BookStatus
        switch currentBookStatus {
        case .willRead:
            nextStatus = .read
        case .read:
            nextStatus = .didRead
        case .didRead:
            nextStatus = .willRead
        }
        
        // ИСПОЛЬЗУЕМ МЕТОД ИЗ DATABASEMANAGER
        DataBaseManager.shared.updateBookStatus(book: book, newStatus: nextStatus)
        
        // Обновляем локальное состояние
        currentBookStatus = nextStatus
        
        print("Статус изменен на: \(nextStatus)")
    }
    
    // MARK: - Note Management
    private func loadNotes() {
        guard let book = book,
              let notesSet = book.notes as? Set<Note> else { return }
        
        notes = notesSet.sorted { ($0.date ?? Date()) > ($1.date ?? Date()) }
    }
    
    private func addNote() {
        guard let book = book,
              !bookNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        DataBaseManager.shared.addNote(book: book, noteText: bookNote)
        DataBaseManager.shared.saveContext()
        
        // Reload notes
        loadNotes()
        
        // Clear text field
        bookNote = ""
    }
    
    private func deleteNote(_ note: Note) {
        note.deleteNote()
        DataBaseManager.shared.saveContext()
        loadNotes() // Refresh the list
    }
}

struct BookCoverView: View {
    var book: Book
    var body: some View {
        if let cover = Image.getImage(folderName: (book.id)!, fileName: "cover.jpeg") {
            cover
                .resizable()
        } else {
            Image(.book2)
                .resizable()
        }
    }
}

// Добавь в любой файл (например, в Utils.swift)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
