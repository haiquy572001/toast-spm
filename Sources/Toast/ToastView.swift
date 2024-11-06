// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 13.0, *)
public struct ToastView: View {
    
    public var size: CGSize
    public var item: ToastItem
    
    @State var animateIn: Bool = false
    @State var animateOut: Bool = false
    
    // Public initializer
    public init(size: CGSize, item: ToastItem) {
        self.size = size
        self.item = item
    }
    
    @available(iOS 13.0, *)
    public var body: some View {
        if #available(iOS 15.0, *) {
            if #available(iOS 16.0, *) {
                HStack(spacing: 0) {
                    if let symbol = item.symbol {
                        if #available(iOS 14.0, *) {
                            Image(systemName: symbol)
                                .font(.title3)
                                .padding(.trailing, 10)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    Text(item.title)
                        .lineLimit(1)
                }
                .foregroundStyle(item.tint)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    .background
                        .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5))
                        .shadow(.drop(color: .primary.opacity(0.06), radius: 8, x: -5, y: -5)),
                    in: .capsule
                )
                .contentShape(.capsule)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded({ value in
                            
                            guard item.isUserInteractionEnabled else { return }
                            
                            let endY = value.translation.height
                            let velocityY = value.velocity.height
                            
                            if (endY + velocityY) > 100 {
                                removeToast()
                            }
                        })
                )
                .offset(y: animateIn ? 0 : 150)
                .offset(y: !animateOut ? 0 : 150)
                .task {
                    
                    guard !animateIn else { return }
                    withAnimation(.snappy) {
                        animateIn = true
                    }
                    
                    try? await Task.sleep(for: .seconds(item.timing.rawValue))
                    
                    removeToast()
                }
                .frame(maxWidth: size.width * 0.7)
                .transition(.offset(y: 150))
            } else {
                // Fallback on earlier versions
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    public var offsetY: CGFloat {
        return 0
    }
    
    public func removeToast() {
        guard !animateOut else { return }
        
        if #available(iOS 17.0, *) {
            withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                animateOut = true
            } completion: {
                removeToastItem()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func removeToastItem() {
        if #available(iOS 17.0, *) {
            Toast.shared.toasts.removeAll(where: { $0.id == item.id })
        } else {
            // Fallback on earlier versions
        }
    }
}


@available(iOS 17.0, *)
@Observable
public class Toast {
    @MainActor static public let shared = Toast()
    public var toasts: [ToastItem] = []
    
    public func present(title: String, symbol: String?, tint: Color = .primary, isUserInteractionEnabled: Bool = false, timing: ToastTime = .medium) {
        
        withAnimation(.snappy) {
            toasts.append(.init(title: title, symbol: symbol, tint: tint, isUserInteractionEnabled: isUserInteractionEnabled, timing: timing))
        }
    }
}
