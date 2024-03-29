import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    let urlString: String
    let webView: WKWebView = WKWebView()
    @State private var prevURL : URL?

    func makeUIView(context: Context) -> WKWebView {
        clearWebViewCache()
        webView.navigationDelegate = context.coordinator
        webView.allowsLinkPreview = false
        webView.isInspectable = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            if (prevURL != url) {
                let request = URLRequest(url: url)
                uiView.load(request)
                DispatchQueue.main.async { prevURL = url }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func clearWebViewCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date) {
        }
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
