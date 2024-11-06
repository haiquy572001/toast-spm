//
//  RootView.swift
//  Toast
//
//  Created by Đoàn Văn Khoan on 4/11/24.
//
import SwiftUI

@available(iOS 17.0, *)
public struct RootViewWithToast<Content: View>: View {
    
    @ViewBuilder public var content: Content
    /// View Properties
    @State public var overlayWindow: UIWindow?
    
    // Public initializer
    public init(content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   overlayWindow == nil
                {
                    let window = PassThroughWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    
                    /// View Controller
                    let rootController = UIHostingController(rootView: ToastGroup())
                    rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
                    rootController.view.backgroundColor = .clear
                    
                    window.rootViewController = rootController
                    window.isHidden = false
                    window.isUserInteractionEnabled = false
                    window.tag = 1000
                    
                    overlayWindow = window
                }
            }
    }
}

class PassThroughWindow: UIWindow {
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        
        return rootViewController?.view == view ? nil : view
    }
}
