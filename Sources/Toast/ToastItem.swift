//
//  ToastItem.swift
//  Toast
//
//  Created by Đoàn Văn Khoan on 4/11/24.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct ToastItem: Identifiable {
    public let id: UUID = .init()
    public var title: String
    public var symbol: String?
    public var tint: Color
    public var isUserInteractionEnabled: Bool
    public var timing: ToastTime = .medium
    
    public init(title: String, symbol: String? = nil, tint: Color, isUserInteractionEnabled: Bool, timing: ToastTime = .medium) {
        self.title = title
        self.symbol = symbol
        self.tint = tint
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.timing = timing
    }
}


public enum ToastTime: CGFloat {
    case short = 1.0
    case medium = 2.0
    case long = 3.5
}
