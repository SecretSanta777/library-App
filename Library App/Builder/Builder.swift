//
//  Builder.swift
//  Library App
//
//  Created by Владимир Царь on 20.10.2025.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    associatedtype PresenterType
    var presenter: PresenterType? { get set }
}

class Builder {
    static private func createView<View: UIViewController & BaseViewProtocol>(viewType: View.Type, presenter: (View) -> View.PresenterType) -> UIViewController {
        let view = View()
        let presenter = presenter(view)
        view.presenter = presenter
        return view
    }
    
    static func createRegistView() -> UIViewController {
        return self.createView(viewType: RegistView.self) { view in
            RegistViewPresenter(view: view)
        }
    }
    
    static func createUnboardingView() -> UIViewController {
        return self.createView(viewType: OnboardingView.self) { view in
            OnboardingViewPresenter(view: view)
        }
    }
    
    static func createMainView() -> UIViewController {
        let mainVC = self.createView(viewType: MainView.self) { view in
            MainViewPresenter(view: view)
        }
        return UINavigationController(rootViewController: mainVC)
        
    }
    
    static func createDetailsView(book: Book ) -> UIViewController {
        return self.createView(viewType: DetailsView.self) { view in
            DetailsViewPresenter(view: view, book: book)
        }
    }
    
    static func createAddView() -> UIViewController {
        return self.createView(viewType: AddBookView.self) { view in
            AddViewPresenter(view: view)
        }
    }
    
    static func createBookListView(books: [BookModelItem]?) -> UIViewController {
        return self.createView(viewType: BookListView.self) { view in
            BookListPresenter(view: view, bookList: books)
        }
    }
    
    static func createAddDetailsView(book: BookModelItem) -> UIViewController {
        return self.createView(viewType: AddDetailsView.self) { view in
            AddDetailsViewPresenter(view: view, book: book)
        }
    }
    
}
