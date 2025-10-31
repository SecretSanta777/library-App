import SwiftUI

struct BookStatusButton: View {
    @Binding var status: BookStatus  // Binding для синхронизации с родителем
    var action: () -> Void
    
    private var btnText: String {
        switch status {
        case .read:
            return "Читаю"
        case .didRead:
            return "Прочитал"
        case .willRead:
            return "Прочитать"
        }
    }
    
    var body: some View {
        Button {
            action()  // Вызываем переданный метод changeBookStatus
        } label: {
            Text(btnText)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
                .font(type: .bold, size: 14)
                .foregroundStyle(.white)
                .background(btnColor().opacity(0.5))
                .clipShape(Capsule())
        }
    }
    
    func btnColor() -> Color {
        switch status {
        case .read:
            return Color.appStatusOne
        case .willRead:
            return Color.appStatusTwo
        case .didRead:
            return Color.appStatusThree
        }
    }
}
