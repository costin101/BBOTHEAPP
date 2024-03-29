import SwiftUI
import WebKit

struct ContentView: View {
    @State private var networkMonitor = NetworkMonitor()
    
    var body: some View {
        if networkMonitor.isConnected {
            NavigationStack {
                WebViewWrapper(urlString: "https://app.bbotheapp.com")
            }
        } else {
            ContentUnavailableView(
                "No Internet Connection",
                systemImage: "wifi.exclamationmark",
                description: Text("Please check your connection and try again.")
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
