//
//  AddDetailsView.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import UIKit
import SwiftUI

protocol AddDetailsViewProtocol: BaseViewProtocol {
    
}

protocol AddDetailsViewDelegate {
    func saveBook(image: ImageType, bookDescription: String, bookName: String, authorName: String)
    func back()
    func createText()
    func setError(error: Error)
    func goToMain()
}

class AddDetailsViewModel: ObservableObject {
    @Published var bookDescription: String = ""
    @Published var isAddError: Bool = false
}

final class AddDetailsView: UIViewController, AddDetailsViewProtocol, AddDetailsViewDelegate {
    
    typealias PresenterType = AddDetailsViewPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentView = AddDetailsViewContent(book: presenter?.book, delegate: self, viewModel: presenter!.viewModel)
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        print(UserDefaults.standard.object(forKey: "name"))
        
    }
    
    func saveBook(image: ImageType, bookDescription: String, bookName: String, authorName: String) {
        presenter?.createBook(image: image, bookDescription: bookDescription, bookName: bookName, authorName: authorName) { result in
            switch result {
            case .success(let success):
                if success {
                    self.goToMain()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createText() {
        //presenter?.viewModel.bookDescription = "qwerty"
        presenter?.createBookDescription()
    }
    
    func setError(error: Error) {
        presenter?.viewModel.isAddError = true
    }
    
    func goToMain() {
        print("Start animation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
