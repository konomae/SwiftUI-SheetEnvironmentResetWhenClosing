import SwiftUI

@main
struct SwiftUISheetResetEnvironmentApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.myEnv, "hello")
        }
    }
}

struct MyEnvKey: EnvironmentKey {
    static var defaultValue: String = "default"
}

extension EnvironmentValues {
    var myEnv: String {
        get { self[MyEnvKey.self] }
        set { self[MyEnvKey.self] = newValue }
    }
}

struct RootView: View {
    enum Sheet: Identifiable {
        case environment
        
        var id: Self { self }
    }
    
    @State var sheet: Sheet?
    
    var body: some View {
        VStack {
            Button("Environemnt") { sheet = .environment }
        }
        .sheet(item: $sheet) { sheet in
            switch sheet {
            case .environment:
                EnvironmentSheet()
            }
        }
    }
}

struct EnvironmentSheet: View {
    @Environment(\.myEnv) var myEnv
    
    var body: some View {
        // First time, this shows "hello".
        // However, when I try to close the sheet, this will shows "default".
        Text(myEnv)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
