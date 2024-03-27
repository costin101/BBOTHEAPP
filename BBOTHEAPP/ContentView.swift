import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    let urlString: String
    let webView: WKWebView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewWrapper

        init(_ parent: WebViewWrapper) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Enable swipe gestures for backward and forward navigation
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            WebViewWrapper(urlString: "https://app.bbotheapp.com")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
