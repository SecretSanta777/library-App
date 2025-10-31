// KeyboardAdaptive.swift
import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    @State private var animationDuration: Double = 0.25
    
    func body(content: Content) -> some View {
        content
            .offset(y: -keyboardHeight) // ← Сдвигаем ВВЕРХ вместо padding снизу
            .animation(.easeOut(duration: animationDuration), value: keyboardHeight)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    guard let userInfo = notification.userInfo,
                          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                          let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
                    
                    animationDuration = duration
                    keyboardHeight = keyboardFrame.height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
                    guard let userInfo = notification.userInfo,
                          let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
                    
                    animationDuration = duration
                    keyboardHeight = 0
                }
            }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
